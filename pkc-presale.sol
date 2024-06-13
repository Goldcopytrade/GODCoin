/**
 *Submitted for verification at testnet.bscscan.com on 2024-06-11
*/

// SPDX-License-Identifier: MIT
pragma solidity =0.8.15;

library SafeMath {
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        _transferOwnership(_msgSender());
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionStaticCall(
        address target,
        bytes memory data
    ) internal view returns (bytes memory) {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionDelegateCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(
                oldAllowance >= value,
                "SafeERC20: decreased allowance below zero"
            );
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(
                token,
                abi.encodeWithSelector(
                    token.approve.selector,
                    spender,
                    newAllowance
                )
            );
        }
    }

    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);
}

interface AggregatorV3Interface {
  
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

contract PKCPresale is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using SafeERC20 for IERC20Metadata;
    uint256 public rate;
    address public saleToken;
    uint public saleTokenDec;
    uint256 public totalTokensforSale;
    mapping(address => bool) public payableTokens;
    mapping(address => uint256) public tokenPrices;
    mapping(address => AggregatorV3Interface) public tokenAggregator;
    bool public saleStatus;
    address[] public buyers;
    mapping(address => BuyerTokenDetails) public buyersAmount;
    uint256 public totalTokensSold;

    struct Account {
        address referrer;
        uint reward;
        uint referredCount;
    }

    struct BuyerTokenDetails {
        uint amount;
        bool exists;
        bool isClaimed;
    }

    uint256[] public levelRate;
    mapping(address => Account) public accounts;
    bool public withoutBuyRef;

    event RegisteredReferer(address referee, address referrer);
    event RegisteredRefererFailed(address referee, address referrer, string reason);
    event PaidReferral(address from, address to, uint amount, uint level);

    constructor() {
        saleStatus = true;
        rate = 6000000000000000; // $0.006
        tokenAggregator[address(0)] = AggregatorV3Interface(0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE); //bnbusd feed address
        levelRate = [1000]; // 3% ~ 300
        withoutBuyRef = false;

        setSaleToken(0x6807b69118a225bAB89014BD3b5e014438C0665B,3000000000000000000000000000,true);
        setPayableTokens(0x55d398326f99059fF775485246999027B3197955,1000000000000000000,0xB97Ad0E74fa7d920791E90258A6E2085088b4320);
    }

    modifier saleEnabled() {
        require(saleStatus == true, "Presale: is not enabled");
        _;
    }
    modifier saleStoped() {
        require(saleStatus == false, "Presale: is not stopped");
        _;
    }

    function setSaleToken(
        address _saleToken,
        uint256 _totalTokensforSale,
        bool _saleStatus
    ) public onlyOwner {
        saleToken = _saleToken;
        saleStatus = _saleStatus;
        saleTokenDec = IERC20Metadata(saleToken).decimals();
        totalTokensforSale = _totalTokensforSale;
    }

    function setSalePrice(uint _rate) external onlyOwner{
        rate = _rate;
    }

    function stopSale() external onlyOwner {
        saleStatus = false;
    }

    function resumeSale() external onlyOwner {
        saleStatus = true;
    }

    function setPayableTokens(
        address _tokens,
        uint _prices,
        address _aggregator
    ) public onlyOwner {
        require(_prices != 0);
        payableTokens[_tokens] = true;
        tokenPrices[_tokens] = _prices;
        tokenAggregator[_tokens] = AggregatorV3Interface(_aggregator);
        
    }

    function payableTokenStatus(
        address _token,
        bool _status
    ) external onlyOwner {
        require(payableTokens[_token] != _status);
        payableTokens[_token] = _status;
    }


    function getTokenAmount(
        address token,
        uint256 amount
    ) public view returns (uint256) {
        uint256 amtOut;
        uint256 price = tokenPrices[token];
        if (tokenAggregator[token] != AggregatorV3Interface(address(0))) {
            price =  uint256(getLatestPrice(tokenAggregator[token])); //bnb price in doller with 8 decimals
        }
        amtOut = amount.mul(price).mul(10 ** saleTokenDec).div(rate).div(10**8);
        return amtOut;
    }

    function getLatestPrice(AggregatorV3Interface _tokenAddress) public view returns (int) {
        int price;
        (,price,,,) = _tokenAddress.latestRoundData(); 
        return price;
    }

    function buyToken(
        address _token,
        uint256 _amount,
        address _referrer
    ) external payable saleEnabled {
         uint256 saleTokenAmt = _token != address(0)
            ? getTokenAmount(_token, _amount)
            : getTokenAmount(address(0), msg.value);
        require(
            (totalTokensSold + saleTokenAmt) < totalTokensforSale,
            "Presale: Not enough tokens to be sale"
        );
        if (_token != address(0)) {
            require(_amount > 0);
            IERC20(_token).safeTransferFrom(msg.sender, address(this), _amount);
        } 

        if(!hasReferrer(msg.sender)) {
            if(buyersAmount[_referrer].exists || withoutBuyRef){
                addReferrer(_referrer);
            }
            else if(buyersAmount[_referrer].exists){
                addReferrer(_referrer);
            }
        }

        payReferral(saleTokenAmt);

        totalTokensSold += saleTokenAmt;
        if (!buyersAmount[msg.sender].exists) {
            buyers.push(msg.sender);
            buyersAmount[msg.sender].exists = true;
        }
        
        IERC20(saleToken).safeTransfer(msg.sender, saleTokenAmt);
        buyersAmount[msg.sender].amount += saleTokenAmt;
    }

    function withdrawAllSaleTokens() external onlyOwner {
        uint256 amt = IERC20(saleToken).balanceOf(address(this));
        IERC20(saleToken).transfer(owner(), amt);
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(owner()).transfer(balance);
    }
    
    function withdrawERC20(address tokenAddress, uint256 amount) external onlyOwner {
        require(tokenAddress != address(0), "Token address cannot be zero");

        IERC20 token = IERC20(tokenAddress);
        uint256 balance = token.balanceOf(address(this));
        require(balance >= amount, "Insufficient balance");
        token.transfer(owner(), amount);
    }


    function hasReferrer(address addr) public view returns(bool){
        return accounts[addr].referrer != address(0);
    }

    function isCircularReference(address referrer, address referee) internal view returns(bool){
        address parent = referrer;

        for (uint i; i < levelRate.length; i++) {
            if (parent == address(0)) {
                break;
            }

            if (parent == referee) {
                return true;
            }

            parent = accounts[parent].referrer;
        }

        return false;
    }

    function addReferrer(address referrer) internal returns(bool){
        if (referrer == address(0)) {
            emit RegisteredRefererFailed(msg.sender, referrer, "Referrer cannot be 0x0 address");
            return false;
        } else if (isCircularReference(referrer, msg.sender)) {
            emit RegisteredRefererFailed(msg.sender, referrer, "Referee cannot be one of referrer uplines");
            return false;
        } else if (accounts[msg.sender].referrer != address(0)) {
            emit RegisteredRefererFailed(msg.sender, referrer, "Address have been registered upline");
            return false;
        }

        Account storage userAccount = accounts[msg.sender];
        Account storage parentAccount = accounts[referrer];
        userAccount.referrer = referrer;
        parentAccount.referredCount = parentAccount.referredCount.add(1);

        emit RegisteredReferer(msg.sender, referrer);
        return true;
    }

   
    function payReferral(uint256 value) internal returns(uint256){
       Account memory userAccount = accounts[msg.sender];
        uint totalReferal;

        for (uint i; i < levelRate.length; i++) {
            address parent = userAccount.referrer;
            Account storage parentAccount = accounts[userAccount.referrer];

            if (parent == address(0)) {
                break;
            }

            uint c = value.mul(levelRate[i]).div(10000);
            totalReferal = totalReferal.add(c);
            
            parentAccount.reward = parentAccount.reward.add(c);
            IERC20(saleToken).safeTransfer(parent, c);
            
            emit PaidReferral(msg.sender, parent, c, i + 1);
            userAccount = parentAccount;
        }
        
        return totalReferal;
    }

    function setLevelRate(uint[] memory _levelRate) public onlyOwner{
        levelRate = _levelRate;
    }

    function setwithoutBuyRef(bool _can) public onlyOwner{
        withoutBuyRef = _can;
    }
}