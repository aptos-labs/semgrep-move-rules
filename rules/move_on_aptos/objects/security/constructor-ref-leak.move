module 0xcafe::constructor_ref_leak {
    use std::object::{Self, ConstructorRef};
    use aptos_framework::object::{Self as aptosObject, ConstructorRef};

    // ruleid: constructor-ref-leak
    public fun signature_1() : ConstructorRef {

    }

    // ok: constructor-ref-leak
    fun signature_2() : ConstructorRef {

    }

    // ruleid: constructor-ref-leak
    public fun signature_3() : (ConstructorRef, u64) {

    }

    // ruleid: constructor-ref-leak
    public fun signature_4() : (u64, ConstructorRef, address, object) {

    }
    
    // ok: constructor-ref-leak
    public(friend) fun signature_5() : (u64, ConstructorRef, object, ConstructorRef) {

    }

    // ok: constructor-ref-leak
    #[test_only]
    public(friend) fun signature_6() : ConstructorRef {

    }
}

#[test_only]
module 0xcafe::test_constructor_ref_leak {
    // ok: constructor-ref-leak
    public fun signature_6() : ConstructorRef {

    }
}