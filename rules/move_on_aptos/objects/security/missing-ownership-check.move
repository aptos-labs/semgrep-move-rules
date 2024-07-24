module 0x42::example {
 
    struct Subscription has key {
        end_subscription: u64
    }
 
    entry fun registration(user: &signer, end_subscription: u64) {
        let price = calculate_subscription_price(end_subscription);
        payment(user,price);
 
        let user_address = address_of(user);
        let constructor_ref = object::create_object(user_address);
        let subscription_signer = object::generate_signer(&constructor_ref);
        move_to(&subscription_signer, Subscription { end_subscription });
    }
 
    entry fun execute_action_with_valid_subscription(
        user: &signer, obj: Object<Subscription>
    ) acquires Subscription {
        let object_address = object::object_address(&obj);
        // ruleid:missing-ownership-check
        let subscription = borrow_global<Subscription>(object_address);
        assert!(subscription.end_subscription >= aptos_framework::timestamp::now_seconds(),1);
        // Use the subscription
        // [...]
    }

    entry fun execute_action_with_valid_subscription_checked(
        user: &signer, obj: Object<Subscription>
    ) acquires Subscription {
        assert!(object::owner(&obj)==address_of(user),ENOT_OWNWER);
        let object_address = object::object_address(&obj);
        // ok:missing-ownership-check
        let subscription = borrow_global<Subscription>(object_address);
        assert!(subscription.end_subscription >= aptos_framework::timestamp::now_seconds(),1);
        // Use the subscription
        // [...]
    }
}