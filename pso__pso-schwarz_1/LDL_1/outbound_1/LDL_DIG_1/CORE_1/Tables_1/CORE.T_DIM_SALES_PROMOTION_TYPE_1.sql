CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_sales_promotion_type_1 (
sale_promo_type_cd STRING(25) NOT NULL
OPTIONS(description='The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.'),
sale_promo_type_name STRING(100) OPTIONS(description='The name for the promotion type in group language'),
sale_promo_type_descr STRING(250)
OPTIONS(description='The textual description for the promotion type in group language'),
sale_promo_type_descr_en STRING(250) DEFAULT ''
OPTIONS(description='The textual description for the promotion type in English'),
sale_promo_type_descr_de STRING(250) DEFAULT ''
OPTIONS(description='The textual description for the promotion type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (sale_promo_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the way the product gets promoted e.g. website, flyer, etc. ( Bestellmagazin, Online Only etc)');