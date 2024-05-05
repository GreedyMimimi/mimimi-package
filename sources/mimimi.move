module mimimi_package::mimimi {
    use std::option;
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::url;
    use sui::tx_context::{Self, TxContext};

    struct MIMIMI has drop {}

    fun init(witness: MIMIMI, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<MIMIMI>(witness, 6, b"MIMIMI", b"MIMIMI", b"No cap, MIMIMI is the real deal.", option::some<url::Url>(url::new_unsafe_from_bytes(b"https://aquamarine-bright-chinchilla-232.mypinata.cloud/ipfs/Qma2U1uBhR3DgG6FJKoY6rDk6bocAyrjrbVRogLCQjnXPo/icon.png")), ctx);
        transfer::public_freeze_object(metadata);
        coin::mint_and_transfer<MIMIMI>(&mut treasury_cap, 10000000000000000000, tx_context::sender(ctx), ctx);
        transfer::public_transfer<TreasuryCap<MIMIMI>>(treasury_cap, @0x0);
    }

    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(MIMIMI {}, ctx)
    }
}
