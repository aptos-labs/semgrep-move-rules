module 0xcafe::constructor_ref_leak {
    use std::object::{Self, ConstructorRef};
    use aptos_framework::object::{Self as aptosObject, ConstructorRef as AptosConstructorRef};

    // ruleid: constructor-ref-leak
    public fun signature_1() : ConstructorRef {

    }

    // ruleid: constructor-ref-leak
    public fun signature_2() : AptosConstructorRef {

    }

    // ruleid: constructor-ref-leak
    public fun signature_3() : (AptosConstructorRef) {

    }

    // ruleid: constructor-ref-leak
    public fun signature_4() : (u64, ConstructorRef, address, object) {

    }
    
    // ok: constructor-ref-leak
    public(friend) fun signature_5() : (u64, ConstructorRef, object) {

    }
}

#[test_only]
module 0xcafe::test_constructor_ref_leak {
    // ok: constructor-ref-leak
    public fun signature_6() : ConstructorRef {

    }
}