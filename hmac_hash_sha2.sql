DELIMITER $$
CREATE FUNCTION `hmac_hash_sha2`(
	`secret_key` VARBINARY(255),
	`data_to_hash` VARBINARY(2048),
	`sha` VARCHAR(6)
) RETURNS VARBINARY(128)
    DETERMINISTIC
BEGIN
	DECLARE `sha_length` INT(3) DEFAULT RIGHT(`sha`, 3);
	DECLARE `block_size` INT(3) DEFAULT IF(`sha_length` <= 256, 64, 128);
	DECLARE `hexkey` VARBINARY(128) DEFAULT RPAD(`secret_key`, `block_size`, 0x00);
	DECLARE `opad` VARBINARY(128) DEFAULT REPEAT(0x5C, `block_size`);    
	DECLARE `ipad` VARBINARY(128) DEFAULT REPEAT(0x36, `block_size`);

	IF `sha` NOT IN ('sha224', 'sha256', 'sha384', 'sha512') THEN
		RETURN 'Invalid `sha` parameter.';
	END IF;

	IF LENGTH(`secret_key`) > `block_size` THEN
		SET `hexkey` = RPAD(UNHEX(SHA2(`secret_key`, `sha_length`)), `block_size`, 0x00);
	END IF;

	SET `opad` = `opad` ^ `hexkey`;
	SET `ipad` = `ipad` ^ `hexkey`;

	RETURN SHA2(CONCAT(`opad`, UNHEX(SHA2(CONCAT(`ipad`, `data_to_hash`), `sha_length`))), `sha_length`);
END$$
DELIMITER ;
