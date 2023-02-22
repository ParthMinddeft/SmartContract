// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4; 

contract DepositWithdraw {
    address public _owner;
    uint public fees = 0.0005 ether;
    uint public constant MAX_FD_BALANCE = 0.5 ether;
    uint public constant MIN_FD_BALANCE = 0.003 ether;
    uint public constant FD_FEES = 0.00005 ether;
    constructor() {
        _setOwner(msg.sender);
    }
    struct Account {
        address owner;
        uint256 balance;
        uint256 accountCreatedTime;
        uint256 lockedBalance;
        uint256 FDCreatedTime;
        bool userCreatedBool;
        uint256 totalLockedTime;
    }
    mapping(address => Account) public MDAccount;
    mapping(address => bool) public BlockListed;
    event balanceAdded(address owner, uint256 balance, uint256 timestamp);
    event withdrawalDone(address owner, uint256 balance, uint256 timestamp);

    modifier minimum() {
        require(msg.value >= 0.0001 ether, "Doesn't follow minimum criteria");
        _;
    }

    function _setOwner(address newOwner) private {
        _owner = newOwner;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }
    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    modifier userAlreadyCreated() {
        require(MDAccount[msg.sender].userCreatedBool == false,"User is Already Created");
        _;
    }
    // account creation
    function accountCreated() public payable minimum userAlreadyCreated() {

        MDAccount[msg.sender].owner = msg.sender;
        MDAccount[msg.sender].balance = msg.value;
        MDAccount[msg.sender].userCreatedBool = true;
        MDAccount[msg.sender].accountCreatedTime = block.timestamp;
        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    modifier userCreated() {
        require(MDAccount[msg.sender].userCreatedBool == true,"please create user with this addres first");
        _;
    }
    modifier checkBlockList() {
        require(BlockListed[msg.sender] == false,"Your account has been blocked");
        _;
    }

    // depositing funds
    function deposit() public payable minimum userCreated checkBlockList {
        MDAccount[msg.sender].balance += msg.value;
        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    // withdrawal
    function withdrawal() public payable userCreated checkBlockList {
        // address.transfer(amount to transfer)
        payable(msg.sender).transfer(MDAccount[msg.sender].balance);
        MDAccount[msg.sender].balance = 0; // clear the balance
        // payable(msg.sender)
        emit withdrawalDone(
            msg.sender,
            MDAccount[msg.sender].balance,
            block.timestamp
        );
    }

    function getBalance(address _add) public view onlyOwner returns(uint256)
    {
        return MDAccount[_add].balance;
    }

    event helpEvent(address _from, uint _amount);
    modifier checkBalance(address _from, uint _amount) {
        require(MDAccount[_from].balance > _amount,"Amount Insuffucient");
        _;
    }
    function TakeHelp(address _from, uint _amount) public checkBalance(_from, _amount) checkBlockList {

        MDAccount[_from].balance -= _amount;
        MDAccount[msg.sender].balance += _amount - fees;
        MDAccount[_owner].balance += fees;

        emit helpEvent(_from, _amount);
    }

    modifier maxBalance(uint256 _amount) {
        require(_amount + MDAccount[msg.sender].lockedBalance <= MAX_FD_BALANCE, "Max balance lock reached");
        _;
    }
    
    modifier minBalance(uint256 _amount) {
        require(_amount >= MIN_FD_BALANCE, "Please add Minimal Balance which is 0.003ETH");
        _;
    }

    function FDFunds(uint256 _amount, uint256 _lockTime) public maxBalance(_amount) checkBlockList minBalance(_amount) {
        MDAccount[msg.sender].lockedBalance += _amount;
        MDAccount[msg.sender].balance -= _amount - FD_FEES;
        MDAccount[_owner].balance += FD_FEES;
        MDAccount[msg.sender].FDCreatedTime = block.timestamp;
        MDAccount[msg.sender].totalLockedTime = MDAccount[msg.sender].FDCreatedTime + _lockTime;
    }
    
    function FDBalance() public view returns(uint) {
        return MDAccount[msg.sender].lockedBalance;
    }

    modifier lockTimeCheck() {
        require(block.timestamp>=MDAccount[msg.sender].totalLockedTime, "Locked time not reached");
        _;
    }

    function FDWithhdraw() public lockTimeCheck checkBlockList{
        MDAccount[msg.sender].balance += MDAccount[msg.sender].lockedBalance;
        MDAccount[msg.sender].lockedBalance = 0;
        MDAccount[msg.sender].totalLockedTime = 0;
        MDAccount[msg.sender].FDCreatedTime = 0;
        if(block.timestamp >= MDAccount[msg.sender].FDCreatedTime + 3*34*60*60) {
            MDAccount[msg.sender].balance += 0.00002 ether;
            MDAccount[_owner].balance -= 0.00002 ether;
        }
    }

    function closeAccount() public payable {
        payable(msg.sender).transfer(MDAccount[msg.sender].balance + MDAccount[msg.sender].lockedBalance);
        MDAccount[msg.sender].balance = 0;
        MDAccount[msg.sender].lockedBalance = 0;
        delete MDAccount[msg.sender];
    }

    function blockUser(address _address) public onlyOwner {
        BlockListed[_address] = true;
    }

}