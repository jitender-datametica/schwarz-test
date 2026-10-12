/* --------------------------------------------------------------------------------
   DDL for table: t_coupon_1
   generated from Powerdesigner on Mittwoch, 19. Juni 2024 15:57:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_coupon_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the Coupon (surrogate key)'),
src_country STRING(20) COLLATE 'und:ci'
OPTIONS(description='part of the identifier of the coupon within LidlPlus/SCRM source system'),
src_id STRING(50) COLLATE 'und:ci'
OPTIONS(description='part of the identifier of the coupon within LidlPlus/SCRM source system'),
coupon_type_cd STRING(40) COLLATE 'und:ci'
OPTIONS(description='unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
coupon_nr STRING(50) COLLATE 'und:ci' OPTIONS(description='a number that is used to identify a certain coupon'),
coupon_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='the name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)'),
loyalty_prog_cd STRING(5) COLLATE 'und:ci' OPTIONS(description='identifier of the loyalty program: LPLUS (LidlPlus)'),
geo_area_sid BIGNUMERIC(38,0) OPTIONS(description='unique identifier of the geographical area (surrogate key)'),
geo_area_cd STRING(5) COLLATE 'und:ci' OPTIONS(description='code of the geographical area'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (coupon_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. A coupon reduces the amount that the customer needs to pay for his/her purchase or gives free products for the purchase.');