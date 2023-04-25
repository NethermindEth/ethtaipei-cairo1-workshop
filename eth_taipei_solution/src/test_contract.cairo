#[contract]
mod TestContract {
    use starknet::ContractAddress;
    use starknet::SyscallResult;
    use starknet::StorageAccess;
    use starknet::StorageBaseAddress;
    use starknet::syscalls::storage_read_syscall;
    use starknet::syscalls::storage_write_syscall;
    use starknet::get_caller_address;

    use eth_taipei_solution::ICallee;
    use eth_taipei_solution::ICalleeDispatcherTrait;
    use eth_taipei_solution::ICalleeDispatcher;

    #[derive(Copy, Drop)]
    struct UserProperty {
        level: u256, 
    }

    impl StorageAccessUserProperty of StorageAccess::<UserProperty> {
        fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<UserProperty> {
            Result::Ok(UserProperty { level: StorageAccess::<u256>::read(address_domain, base)?,  })
        }

        fn write(
            address_domain: u32, base: StorageBaseAddress, value: UserProperty
        ) -> SyscallResult<()> {
            StorageAccess::<u256>::write(address_domain, base, value.level)
        }
    }

    struct Storage {
        owner: ContractAddress,
        userProperties: LegacyMap<ContractAddress, UserProperty>,
    }

    #[event]
    fn NewLevel(user: ContractAddress, level: u256) {}

    #[event]
    fn NewOwner(new_owner: ContractAddress) {}

    #[constructor]
    fn constructor(_owner: ContractAddress) {
        owner::write(_owner);
    }

    #[view]
    fn getUserProperty(user: ContractAddress) -> (u256) {
        let res = userProperties::read(user);
        (res.level)
    }

    fn only_owner() {
        let msg_sender = get_caller_address();
        assert(msg_sender == owner::read(), 'Not owner');
    }

    #[external]
    fn change_owner(new_owner: ContractAddress) {
        only_owner();
        owner::write(new_owner);

        NewOwner(new_owner);
    }

    #[external]
    fn set_level(user: ContractAddress, level: u256) {
        only_owner();
        userProperties::write(user, UserProperty { level: level });

        NewLevel(user, level);
    }

    #[view]
    fn get_number(targetAddress: ContractAddress) -> u256 {
        ICalleeDispatcher { contract_address: targetAddress }.get_number()
    }
}
