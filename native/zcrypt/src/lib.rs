use rand::rngs::OsRng;
use rsa::{PaddingScheme, PublicKey, RSAPrivateKey, RSAPublicKey};


pub struct Crypt {
    data:Vec<u8>,
}

pub fn add(a: i64, b: i64) -> i64 {
    a.wrapping_add(b)
}

pub fn encrypt()-> Crypt {
    let mut rng = OsRng;
    let bits = 2048;
    let private_key = RSAPrivateKey::new(&mut rng, bits).expect("failed to generate a key");
    let public_key = RSAPublicKey::from(&private_key);

    // Encrypt
    let data = b"hello world";
    let padding = PaddingScheme::new_pkcs1v15_encrypt();
    let mut enc_data = public_key
        .encrypt(&mut rng, padding, &data[..])
        .expect("failed to encrypt");

    assert_ne!(&data[..], &enc_data[..]);

    /* // Decrypt
    let padding = PaddingScheme::new_pkcs1v15_encrypt();
    let dec_data = private_key
        .decrypt(padding, &enc_data)
        .expect("failed to decrypt");
    assert_eq!(&data[..], &dec_data[..]); */
//let cstr = unsafe { CStr::from_bytes_with_nul(&enc_data[..]) };
 //let mut c_ptr: *const c_char = cstr.unwrap().as_ptr();
    return Crypt {
        data: enc_data,
    }


}
