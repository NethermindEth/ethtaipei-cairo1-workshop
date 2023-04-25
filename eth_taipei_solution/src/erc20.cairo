#[contract]
mod ERC20 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;

    struct Storage {
        _name: felt252,
        _symbol: felt252,
        _total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress, ContractAddress), u256>,
    }

    #[event]
    fn Transfer(from: ContractAddress, to: ContractAddress, value: u256) {}

    #[event]
    fn Approval(owner: ContractAddress, spender: ContractAddress, value: u256) {}

    #[constructor]
    fn contructor() {
        _name::write(21806976760243566);
        _symbol::write(21806976760243566)
    }

    #[view]
    fn name() -> felt252 {
        _name::read()
    }

    #[view]
    fn symbol() -> felt252 {
        _symbol::read()
    }

    #[view]
    fn decimal() -> u8 {
        18_u8
    }

    #[view]
    fn totalSupply() -> u256 {
        _total_supply::read()
    }

    #[view]
    fn balanceOf(account: ContractAddress) -> u256 {
        balances::read(account)
    }

    #[external]
    fn transfer(to: ContractAddress, amount: u256) -> bool {
        let owner = get_caller_address();
        _transfer(owner, to, amount);
        true
    }

    fn _transfer(from: ContractAddress, to: ContractAddress, amount: u256) {
        assert(!from.is_zero(), 'Transfer from the zero address');
        assert(!to.is_zero(), 'Transfer to the zero address');

        let from_balance = balances::read(from);
        assert(from_balance >= amount, 'Transfer amount exceeds balance');

        balances::write(from , from_balance - amount);
        balances::write(to, balances::read(to) + amount);

        Transfer(from, to, amount);
    }

    #[external]
    fn approve(spender: ContractAddress, amount: u256) -> bool {
        let owner = get_caller_address();
        _approve(owner, spender, amount);
        true
    }

    fn _approve(owner: ContractAddress, spender: ContractAddress, amount: u256) {
        assert(!owner.is_zero(), 'Approve from the zero address');
        assert(!spender.is_zero(), 'Approve to the zero address');

        allowances::write((owner, spender), amount);

        Approval(owner, spender, amount);
    }

    fn transferFrom(from: ContractAddress, to: ContractAddress, amount: u256) -> bool {
        let spender = get_caller_address();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        true
    }

    fn _spendAllowance(owner: ContractAddress, spender: ContractAddress, amount: u256) {
        let current_allowance = allowances::read((owner, spender));
        let ONES_MASK = 0xffffffffffffffffffffffffffffffff_u128;
        let is_unlimited_allowance =
            current_allowance.low == ONES_MASK & current_allowance.high == ONES_MASK;
        if(!is_unlimited_allowance) {
            assert(current_allowance >= amount, 'Insufficient allowance');
            _approve(owner, spender, current_allowance - amount);
        }
    }
}
