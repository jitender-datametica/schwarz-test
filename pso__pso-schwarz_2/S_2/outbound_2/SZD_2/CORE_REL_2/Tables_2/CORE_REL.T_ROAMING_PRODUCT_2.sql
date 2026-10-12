/* --------------------------------------------------------------------------------
   DDL for table: T_ROAMING_PRODUCT_2
   generated from Powerdesigner on Donnerstag, 16. November 2023 10:54:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_roaming_product_2 (
roaming_product_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of the roaming product.'),
roaming_interface_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the roaming interface.'),
roaming_product_name STRING(100) NOT NULL
OPTIONS(description='Natural/Business Key - The unique name of the roaming product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (roaming_product_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The roaming tariff used when roaming is active during a charging session. Roaming is active if the operator of the charge point is different from the seller of the power for charging the car. - Source IOTCharger');