module 0x42::object_without_signer {
    use std::signer;
    use aptos_framework::object::{Self, Object};

    struct MyObject has key {
        value: u64
    }

    // ruleid: object-without-signer
    public fun unsafe_public_function(_obj: Object<MyObject>) {
        // Missing ownership check
        let _ = object::object_address(&obj);
    }

    // ruleid: object-without-signer
    entry fun unsafe_entry_function(_obj: Object<MyObject>) {
        // Missing ownership check
        let _ = object::object_address(&obj);
    }

    // ruleid: object-without-signer
    public entry fun unsafe_public_entry_function(_obj: Object<MyObject>) {
        // Missing ownership check
        let _ = object::object_address(&obj);
    }

    // ruleid: object-without-signer
    public(friend) entry fun unsafe_friend_entry_function(_obj: Object<MyObject>) {
        // Missing ownership check
        let _ = object::object_address(&obj);
    }

    // ok: object-without-signer
    fun safe_function(signer: &signer, obj: Object<MyObject>) {
        assert!(object::owner(&obj) == signer::address_of(signer), 0);
        let _ = object::object_address(&obj);
    }

    // ok: object-without-signer
    inline fun safe_inline(obj: Object<MyObject>) {
        let _ = object::object_address(&obj);
    }

    // ok: object-without-signer
    public inline fun safe_public_inline(obj: Object<MyObject>) {
        let _ = object::object_address(&obj);
    }

    // ok: object-without-signer
    #[view]
    fun safe_view(obj: Object<MyObject>) {
        let _ = object::object_address(&obj);
    }
} 