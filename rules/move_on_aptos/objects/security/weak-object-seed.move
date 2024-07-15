module 0x42::example {
  use std::string::{Self, String};
  use std::vector;
  use aptos_framework::object::{Self, Object};

  public fun get_pool_address_unsafe(token_1: Object<Metadata>, token_2: Object<Metadata>): address {
    let token_symbol = string::utf8(b"LP-");
    string::append(&mut token_symbol, fungible_asset::symbol(token_1));
    string::append_utf8(&mut token_symbol, b"-");
    string::append(&mut token_symbol, fungible_asset::symbol(token_2));
    let seed = *string::bytes(&token_symbol);

    // ruleid: weak-object-seed
    object::create_object_address(&@swap, seed)
  }

  public fun get_pool_address_unsafe2(token_1: Object<Metadata>, token_2: Object<Metadata>): address {
    let seeds = vector::empty<u8>();
    // ruleid: weak-object-seed
    object::create_object_address(&@swap, seeds)
  }

  public fun get_pool_address_safe(token_1: Object<Metadata>, token_2: Object<Metadata>): address {
    let seeds = vector[1,2];
    vector::append(&mut seeds, bcs::to_bytes(&object::object_address(&token_1)));
    vector::append(&mut seeds, bcs::to_bytes(&object::object_address(&token_2)));

    // ok: weak-object-seed
    object::create_object_address(&@swap, seeds)
  }
}