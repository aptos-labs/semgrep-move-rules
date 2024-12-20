module 0xdeadbeef::signer_leak {
    // ruleid: signer-leak
    public fun signature_1() : signer {
        
    }

    // ruleid: signer-leak
    public fun signature_2() : &signer {
        
    }

    // ruleid: signer-leak
    public fun signature_7() : (signer) {
        
    }

    // ruleid: signer-leak
    #[attr]
    public fun signature_9() : (u64, &signer, address, object) {
        
    }

    // ok: signer-leak
    fun signature_3() : signer {
        
    }

    // ok: signer-leak
    #[test]
    public fun signature_4() : &signer {
        
    }

    // ok: signer-leak
    public(friend) fun signature_5() : signer {
        
    }

    // ok: signer-leak
    #[attr, test_only]
    public fun signature_6() : &signer {
        
    }

    // ok: signer-leak
    #[attr1(key = value), test(attr2 = value)]
    public fun signature_8() : (signer, u64) {
        
    }
}

#[test_only]
module 0xdeadbeef::test_signer_leak {
    // ok: signer-leak
    public fun signature_10() : signer {
        
    }
}