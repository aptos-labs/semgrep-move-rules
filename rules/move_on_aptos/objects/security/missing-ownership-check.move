module 0x42::ownership_check_test {
    use std::signer;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::signer::address_of;
    use aptos_framework::fungible_asset::{Self,Metadata};

    struct MyObject has key {
        value: u64
    }
    
    // ruleid: missing-ownership-check2
    public fun unsafe_function(signer: &signer, obj: Object<MyObject>) {
        // Missing ownership check but using both parameters
        let signer_addr = address_of(signer);
        let obj_addr = object::object_address(&obj);
    }

    // ruleid: missing-ownership-check2
    entry fun unsafe_entry(signer: &signer, obj: Object<MyObject>) {
        // Missing ownership check
        let obj_addr = object::object_address(&obj);
    }

    // ruleid: missing-ownership-check2
    public(friend) entry fun unsafe_friend_entry(signer: &signer, obj: Object<MyObject>) {
        // Missing ownership check
        let obj_addr = object::object_address(&obj);
    }

    // ruleid: missing-ownership-check2
    public entry fun unsafe_public_entry(signer: &signer, obj: Object<MyObject>) {
        // Missing ownership check
        let obj_addr = object::object_address(&obj);
    }

    // ruleid: missing-ownership-check2  
    public fun unsafe_owner_check_wrong_comparison(signer: &signer, obj: Object<MyObject>) {
        // This is unsafe because it's comparing addresses incorrectly
        let owner = object::owner(obj);
        let signer_addr = address_of(signer);
        assert!(owner != signer_addr, 0); // Wrong comparison operator
        let obj_addr = object::object_address(&obj);
    }

    // ruleid: missing-ownership-check2
    public fun unsafe_with_type_param<T: key>(signer: &signer, obj: Object<T>) {
        // Missing ownership check with type parameter
        let obj_addr = object::object_address<T>(&obj);
    }

    // ruleid: missing-ownership-check2
    public fun unsafe_oneline(signer: &signer,obj1: Object<MyObject>) {
        assert!(object::owner(obj1) != address_of(signer), 0);
    }

    // ok: missing-ownership-check2
    public fun safe_metadata_object(signer: &signer, obj: Object<Metadata>) {
        assert!(object::owner(obj) == address_of(signer),0);
        let obj_addr = object::object_address(&obj);
    }
    
    // ok: missing-ownership-check2
    public fun safe_direct_check(sig: &signer, obj: Object<MyObject>) {
        assert!(object::owner(obj) == address_of(sig),0);
        let obj_addr = object::object_address(&obj);
    }

    // ok: missing-ownership-check2
    public fun safe_with_temp_vars(signer: &signer, obj: Object<MyObject>) {
        let signer_addr = address_of(signer);
        let owner = object::owner(obj);
        assert!(owner == signer_addr, 0);
        let obj_addr = object::object_address(&obj);
    }
    
    // ok: missing-ownership-check2
    public fun safe_owner_check_with_let(signer: &signer, obj: Object<MyObject>) {
        let owner = object::owner(obj);
        let signer_addr = address_of(signer);
        assert!(owner == signer_addr, 0);
        let obj_addr = object::object_address(&obj);
    }

    // ok: missing-ownership-check2
    public fun safe_owner_check_nested(signer: &signer, obj: Object<MyObject>) {
        assert!(
            object::owner(obj) == address_of(signer),
            0
        );
        let obj_addr = object::object_address(&obj);
    }

    // ok: missing-ownership-check2
    public fun safe_owner_check_multiple(
        signer: &signer, 
        obj1: Object<MyObject>,
        obj2: Object<MyObject>
    ) {
        let signer_addr = address_of(signer);
        assert!(object::owner(obj1) == signer_addr, 0);
        assert!(object::owner(obj2) == signer_addr, 0);
        let obj_addr = object::object_address(&obj1);
    }

    // ok: missing-ownership-check2
    public fun safe_owner_check_reversed(signer: &signer, obj: Object<MyObject>) {
        assert!(address_of(signer) == object::owner(obj), 0);
        let obj_addr = object::object_address(&obj);
    }

    // ok: missing-ownership-check2
    public fun fix_me_safe_with_type_param<T: key>(signer: &signer, obj: Object<T>) {
        assert!(aptos_framework::object::owner<T>(obj) == address_of(signer), 0);
        let obj_addr = object::object_address<T>(&obj);
    }

    // ok: missing-ownership-check2
    public fun fix_me_safe_multiple_type_params<T: key, U: key>(signer: &signer,obj1: Object<T>,obj2: Object<U>) {
        let signer_addr = address_of(signer);
        assert!(aptos_framework::object::owner<T>(obj1) == signer_addr, 0);
        assert!(aptos_framework::object::owner<U>(obj2) == signer_addr, 0);
        let obj_addr = object::object_address<T>(&obj1);
    }

    // ok: missing-ownership-check2
    public fun safe_oneline(signer: &signer,obj1: Object<MyObject>) {
        assert!(object::owner(obj1) == address_of(signer), 0);
    }


    // ok: missing-ownership-check2
    public entry fun safe_use_object_before_check(arg0: &signer, arg1: aptos_framework::object::Object<MyObject>, arg2: address) {
        let v0 = aptos_framework::object::object_address(&arg1);
        assert!(exists<MyObject>(v0), 0);
        assert!(aptos_framework::object::is_owner<MyObject>(arg1, aptos_framework::signer::address_of(arg0)), 0);
        let v1 = 1;
    }

    // ok: missing-ownership-check2
    public fun safe_restricted_fixed_address(signer: &signer,obj: Object<MyObject>) {
        assert!(address_of(signer) == @0x123, 0);
        let obj_addr = object::object_address(&obj);
    }

    struct Acl has key {
        admin: address
    }

    // ok: missing-ownership-check2
    public fun safe_restricted_address_using_struct(signer: &signer, obj: Object<Acl>) {
        let object_address = object::object_address(&obj);
        let acl = borrow_global<Acl>(object_address);
        assert!(address_of(signer) == acl.admin, 0);
        let obj_addr = object::object_address(&obj);
    }


    // ok: missing-ownership-check2
    public fun safe_restricted_address_using_struct_with_borrow_global_mut(signer: &signer, obj: Object<Acl>) {
        let object_address = object::object_address(&obj);
        let acl = borrow_global_mut<Acl>(object_address);
        assert!(address_of(signer) == acl.admin, 0);
        let obj_addr = object::object_address(&obj);
    }

    fun is_admin(addr: address): bool {
        addr == @0x123
    }

    // ok: missing-ownership-check2
    public fun safe_restricted_address_using_function(signer: &signer, obj: Object<Acl>) {
        assert!(is_admin(address_of(signer)), 0);
        let obj_addr = object::object_address(&obj);
    }

    // ok: missing-ownership-check2
    public entry fun safe_oneline_function<T0: key>(arg0: &signer, arg1: aptos_framework::object::Object<T0>, arg2: address) {
        aptos_framework::object::transfer<T0>(arg0, arg1, arg2);
    }

    // ruleid: missing-ownership-check2
    public entry fun unsafe_oneline_function<T0: key>(arg0: &signer, arg1: aptos_framework::object::Object<T0>, arg2: address) {
        aptos_framework::object::transfer<T0>(return_signer(), arg1, arg2);
    }

    fun is_owner(arg0: &signer, arg1: aptos_framework::object::Object<MyObject>) {
        assert!(aptos_framework::object::is_owner<MyObject>(arg1, aptos_framework::signer::address_of(arg0)),0);
    }

    // ok: missing-ownership-check2
    public entry fun safe_sanitizer_inside_internal_function(arg0: &signer, arg1: aptos_framework::object::Object<MyObject>) {
        is_owner(arg0,arg1);
        let v0 = aptos_framework::object::object_address<MyObject>(&arg1);
    }

    // ok: missing-ownership-check2
    public entry fun abort1(arg0: &signer, arg1: aptos_framework::object::Object<MyObject>) {
        abort 1;
    }

    // ok: missing-ownership-check2
    public entry fun abort2(arg0: &signer, arg1: aptos_framework::object::Object<MyObject>) {
        if (true) {
            abort 1
        };
    }
}
