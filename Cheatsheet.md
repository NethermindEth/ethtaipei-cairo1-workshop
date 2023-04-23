## Contract

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
            contract ERC20 {
                ...
            }
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
            #[contract]
            mod ERC20 {
                ...
            }
        </pre>
    </td>
</tr>
</table>

## Storage

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
            mapping(address => uint256) private _balances;
            mapping(address => mapping(address => uint256)) private _allowances;
            uint256 private _totalSupply;
            string private _name;
            string private _symbol;
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
            use starknet::ContractAddress;
            struct Storage {
                _balances: LegacyMap<ContractAddress, u256>,
                _allowances: LegacyMap<ContractAddress, u256>,
                _totalSupply: u256,
                _name: felt252,
                _symbol: felt252,
            }
        </pre>
    </td>
</tr>
</table>

## Events

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
#[event]
fn Transfer(from: ContractAddress, to: ContractAddress, value: u256);

#[event]
fn Approval(owner: ContractAddress, spender: ContractAddress, value: u256);
</pre>
</td>

</tr>
</table>

## Constructor

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
constructor(string memory name_, string memory symbol_) {
     _name = name_;
    _symbol = symbol_;
}
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
#[constructor]
fn constructor(name_: felt252, symbol_: felt252) {
	_name::write(name_);
	_symbol::write(symbol_);
}
        </pre>
    </td>
</tr>
</table>

## View function

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
function name() public view returns (string memory) {
    return _name;
}
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
#[view]
fn name() -> felt252 {
	_name::read()
}
        </pre>
    </td>
</tr>
</table>

## External function

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
function transfer(address to, uint256 amount) public returns (bool) { ... }
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
#[external]
fn transfer(to: ContractAddress, amount: u256) -> bool {...}
        </pre>
    </td>
</tr>
</table>

## Internal function

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
function _transfer(address from, address to, uint256 amount) internal {..}
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
fn _transfer(from: ContractAddress, to: ContractAddress, amount: u256) {...}
        </pre>
    </td>
</tr>
</table>

## msg.sender

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
address owner = msg.sender;
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
    use starknet::get_caller_address;
    let owner = get_caller_address();
        </pre>
    </td>
</tr>
</table>

## revert & require

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
   require(from != address(0), "ERC20: transfer from the zero address");
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
    use zeroable::Zeroable;
    use starknet::ContractAddressZeroable;
    assert(!from.is_zero(), 'Transfer from the zero address');
        </pre>
    </td>
</tr>
</table>

## Emit events

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
   emit Transfer(address(0), account, amount);
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
    Transfer(ContractAddressZeroable::zero(), account, amount);
        </pre>
    </td>
</tr>
</table>

## type(uint256).max

<table>
<tr>
    <td>Solidity</td>
    <td>
        <pre>
   type(uint256).max
        </pre>
    </td>
</tr>
<tr>
    <td>Cairo 1</td>
    <td>
        <pre>
    fn _isMax(num: u256) -> bool {
        let MAX = 0xffffffffffffffffffffffffffffffff_u128;
        num.low == MAX & num.high == MAX
    }
        </pre>
    </td>
</tr>
</table>

## Compile

```
scarb build
```

## Declare

```
starknet declare --contract <json_file>  --account version_11
```

## Deploy
```
starknet deploy --class_hash <class_hash> --account version_11
```

## Reference
https://github.com/starkware-libs/cairo/tree/main/corelib/src