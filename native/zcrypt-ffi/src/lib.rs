use zcrypt::Crypt;

#[no_mangle]
pub extern "C" fn add(a: i64, b: i64) -> i64 {
    zcrypt::add(a, b)
}

#[no_mangle]
pub extern "C" fn encrypt() -> Crypt {
    return zcrypt::encrypt();
}
