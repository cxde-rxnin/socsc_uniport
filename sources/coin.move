module coin::Obxd;

use sui::coin::{Self, TreasuryCap};
use sui::tx_context::TxContext;
use sui::transfer;
use sui::url::Url;
use std::option;

public struct OBXD has drop {}

fun init(witness: OBXD, ctx: &mut TxContext) {
    let multiplier = 100000000;
    let (mut treasury, metadata) = coin::create_currency<OBXD>(
        witness,
        8,
        b"OBXD",
        b"Obxd on Sui",
        vector[],
        std::option::none<sui::url::Url>(),
        ctx,
    );


    let initial_coins = coin::mint(
        &mut treasury,
        200 * multiplier,
        ctx,
    );
    transfer::public_transfer(initial_coins, sui::tx_context::sender(ctx));

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, sui::tx_context::sender(ctx));
}

public fun mint(
    treasury_cap: &mut TreasuryCap<OBXD>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext,
) {
    let coin = coin::mint(
        treasury_cap,
        amount,
        ctx,
    );
    transfer::public_transfer(coin, recipient);
}