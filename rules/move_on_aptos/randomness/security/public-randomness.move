module 0xcafe::public_randomness {
    // ruleid: public-randomness
    #[randomness]
    public fun signature_1() : u64 {
        0
    }

    // ruleid: public-randomness
    #[lint::allow_unsafe_randomness]
    public fun signature_2() : u64 {
        0
    }

    // ok: public-randomness
    #[randomness]
    public(friend) fun signature_3() : u64 {
        0
    }

    // ok: public-randomness
    #[test, randomness]
    public fun signature_4() : u64 {
        0
    }
}

#[test_only]
module 0xcafe::test_public_randomness {
    // ok: public-randomness
    #[randomness]
    public fun signature_5() : u64 {
        0
    }
}