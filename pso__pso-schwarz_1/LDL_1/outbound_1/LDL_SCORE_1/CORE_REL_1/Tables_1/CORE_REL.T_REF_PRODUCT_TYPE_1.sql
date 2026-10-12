--==============================================================
-- Table: t_ref_product_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_product_type_1
   generated from Powerdesigner on Montag, 26. August 2024 08:10:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_product_type_1 (
product_type_cd STRING(20) NOT NULL OPTIONS(description='A code for the type of the product e.g. TRADE.'),
product_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the product_type_cd written out in group language (German).'),
product_type_descr_de STRING(100)
OPTIONS(description='A textual description for the product_type_cd written out in German.'),
product_type_descr_en STRING(100)
OPTIONS(description='A textual description for the product_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (product_type_cd) NOT ENFORCED
)
OPTIONS(description='Dscribes the purpose of the goods. In our case it is only defined by the product_type_cd = TRADE = Trading Goods (Handelsware).');