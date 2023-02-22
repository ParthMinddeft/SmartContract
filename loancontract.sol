// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4; 

contract DepositWithdraw {
    uint public fdamount;
    uint public time;
    uint public lock_period;
    uint public _fdamount;
    mapping (address => uint) fdbalance;
    mapping (address => uint) savebalance;
    uint fees=0.00002 ether;
    uint public constant fee = 0.00001 ether;
    uint public constant MAX_BALANCE = 0.5 ether;
    mapping (address => uint256) balances;
    mapping (address => uint256) lockPeriods;
    address public _owner;
    constructor() {
        _setOwner(msg.sender);
    }
    struct Account {
        address owner;
        uint256 balance;
        uint256 accountCreatedTime;
        uint256 lockedBalance;
        uint256 FDCreatedTime;
        uint256 totalLockedTime;
    }
    mapping(address => Account) public MDAccount;
    mapping(address => bool) public blocklistUsers;

    event balanceAdded(address owner, uint256 balance, uint256 timestamp);
    event withdrawalDone(address owner, uint256 balance, uint256 timestamp);

    modifier minimum() {
        require(msg.value >= 1 ether, "Doesn't follow minimum criteria");
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

    // account creation
    function accountCreated() public payable minimum {

        MDAccount[msg.sender].owner = msg.sender;
        MDAccount[msg.sender].balance = msg.value;
        MDAccount[msg.sender].accountCreatedTime = block.timestamp;
        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    // depositing funds
    function deposit() public payable minimum {
        MDAccount[msg.sender].balance += msg.value;
        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    // withdrawal
    function withdrawal() public payable {
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

    function TakeHelp(address from,address to,uint _amount) public {
        //to.transfer(amount);
        require(MDAccount[from].balance >=_amount + fee,"Sender does not have enough balance");
        //require(to == address(0), "address cannot be 0X0");
        MDAccount[from].balance-=_amount;
        MDAccount[to].balance+=_amount;
    }

    // function receiveether() public payable {

    // }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
    
    modifier maxBalance(uint _amount) {
        require(_amount + MDAccount[msg.sender].lockedBalance <= MAX_BALANCE,"Max balance lock reached");
        _;
    }

    function FDFunds(uint256 _amount, uint256 _lockTime) public maxBalance(_amount) {
        MDAccount[msg.sender].lockedBalance += _amount;
        MDAccount[msg.sender].FDCreatedTime = block.timestamp;
        MDAccount[msg.sender].totalLockedTime = MDAccount[msg.sender].FDCreatedTime + _lockTime;
        MDAccount[msg.sender].balance -= _amount;
    }
    
    function FDBalance() public view returns(uint) {
        return MDAccount[msg.sender].lockedBalance;
    }

    modifier lockTimeCheck() {
        require(block.timestamp>MDAccount[msg.sender].totalLockedTime, "Locked time not reached");
        _;
    }

    function FDWithhdraw() public lockTimeCheck {
        MDAccount[msg.sender].balance += MDAccount[msg.sender].lockedBalance;
        MDAccount[msg.sender].lockedBalance = 0;
        MDAccount[msg.sender].totalLockedTime = 0;
        MDAccount[msg.sender].FDCreatedTime = 0;
    }

    function accountCreated(address accountdetail) public payable minimum {
        MDAccount[accountdetail].owner = accountdetail;
        MDAccount[accountdetail].balance = msg.value;
        MDAccount[accountdetail].accountCreatedTime = block.timestamp;
        emit balanceAdded(accountdetail,msg.value,block.timestamp);
    }

    function FDFund(uint _fdamount1, uint _lock_period1) public 
    {
        require(MDAccount[msg.sender].balance >=_fdamount1,"You do not have that much funds");
        require(_fdamount1 >= 0.003 ether,"amount must be more than 0.003 ether");
        require(fdamount<=0.5 ether,"max amount reached");
        lock_period=_lock_period1;
        uint FD_fees=0.00005 ether;
        MDAccount[msg.sender].balance-=_fdamount1;
        MDAccount[msg.sender].balance-=FD_fees;
        MDAccount[_owner].balance+=FD_fees;
        fdamount+=_fdamount1;
        time=block.timestamp+lock_period;
    }

    function fdwithdraw() public {
        uint withtime = time + 259200;
        require(time<=block.timestamp,"please wait");
        if(block.timestamp>withtime)
        {
            fdamount+=fees;
            MDAccount[_owner].balance-=fees;
        }
        MDAccount[msg.sender].balance+=fdamount;
        fdamount-=fdamount;
    }

    modifier onlyforowner() {
        require(_fdamount >= 0.003 ether,"amount must be more than 0.003 ether");
        _;
    }

    modifier onlyowner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function close_account() public {
        delete MDAccount[msg.sender];
    }

    function addToBlocklist(address user) public onlyowner{
        blocklistUsers[user] = true;
        close_account();
    }

    function removefromblocklist(address user) public onlyowner{
        blocklistUsers[user] = false;
    }

    function createaccount() public {
        require(!blocklistUsers[msg.sender], "Account create is not allowed for this user");
        balances[msg.sender]=0;
        savebalance[msg.sender]=0;
        fdbalance[msg.sender]=0;
    }
}