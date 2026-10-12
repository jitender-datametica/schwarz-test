CREATE TABLE IF NOT EXISTS ldl_data_etl.t_brand_type_2 (
brand_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of a brand. It distinguishes between own brands and other retailer brands.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
brand_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the kind of a brand.'),
PRIMARY KEY (brand_type_cd, lang_cd) NOT ENFORCED
);