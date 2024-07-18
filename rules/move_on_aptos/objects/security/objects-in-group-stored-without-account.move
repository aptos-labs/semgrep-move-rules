module 0x42::example {
  #[resource_group(scope = global)]
  struct ObjectGroup { }
 
  #[resource_group_member(group = 0x42::example::ObjectGroup)]
  struct Monkey has store, key { }
 
  #[resource_group_member(group = 0x42::example::ObjectGroup)]
  struct Toad has store, key { }
 
  fun mint_two(sender: &signer, recipient: &signer) {
    let constructor_ref = &object::create_object_from_account(sender);
    let sender_object_signer = object::generate_signer(constructor_ref);
    let sender_object_addr = object::address_from_constructor_ref(constructor_ref);
 
    move_to(sender_object_signer, Monkey{});
    move_to(sender_object_signer, Toad{});
    let monkey_object: Object<Monkey> = object::address_to_object<Monkey>(sender_object_addr);

    // ruleid: objects-in-group-stored-without-account
    object::transfer<Monkey>(sender, monkey_object, signer::address_of(recipient));
  }

  fun mint_two_safe(sender: &signer, recipient: &signer) {
    let sender_address = signer::address_of(sender);
 
    let constructor_ref_monkey = &object::create_object(sender_address);
    let constructor_ref_toad = &object::create_object(sender_address);
    let object_signer_monkey = object::generate_signer(&constructor_ref_monkey);
    let object_signer_toad = object::generate_signer(&constructor_ref_toad);
 
    move_to(object_signer_monkey, Monkey{});
    move_to(object_signer_toad, Toad{});
 
    let object_address_monkey = signer::address_of(&object_signer_monkey);
 
    let monkey_object: Object<Monkey> = object::address_to_object<Monkey>(object_address_monkey);

    // ok: objects-in-group-stored-without-account
    object::transfer<Monkey>(sender, monkey_object, signer::address_of(recipient));
  }
}