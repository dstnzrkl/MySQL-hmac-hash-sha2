### MySQL function to compute Hashed Message Authentication Codes using SHA2 (224, 256, 384, and 512)

Function Call:
```
hmac_hash_sha2(<`secret_key` VARBINARY(255)>, <`data_to_hash` VARBINARY(2048)>, <`sha` VARCHAR(6)>)
```

The MySQL function hmac_hash_sha2 contained in [hmac_hash_sha2.sql](hmac_hash_sha2.sql) will take `secret_key` and `data_to_hash` to create an HMAC hash using the `sha` algorithm specified.

For `sha`, you can provide:
- sha224
- sha256
- sha384
- sha512

The file [rfc4231_tests.sql](rfc4231_tests.sql) contains the seven tests vectors from [RFC 4231](https://datatracker.ietf.org/doc/html/rfc4231#section-4)

See the function and tests in action on [DB Fiddle](https://www.db-fiddle.com/f/bzDh7CYLDHTNevdvwSX8hM/1)
