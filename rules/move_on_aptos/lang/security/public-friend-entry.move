module 0xabcdef::public_friend_entry {
    // ruleid: public-friend-entry
    public(friend) entry fun signature_1() {

    }

    // ok: public-friend-entry
    public entry fun signature_2() {

    }

    // ok: public-friend-entry
    public(friend) fun signature_3() {

    }

    // ok: public-friend-entry
    #[test]
    public(friend) entry fun signature_4() {

    }
}