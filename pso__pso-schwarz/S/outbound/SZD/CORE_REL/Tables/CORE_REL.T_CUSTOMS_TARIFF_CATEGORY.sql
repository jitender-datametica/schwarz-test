/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_TARIFF_CATEGORY
   generated from Powerdesigner on Montag, 31. Juli 2023 10:46:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_tariff_category (
customs_tariff_category_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs tariff category.'),
customs_tariff_category_descr STRING(250) NOT NULL
OPTIONS(description='A brief description of the customs tariff category.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_tariff_category_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - A customs tariff number can be associated to different categories that are not mutualy exclusive. These categories are defined in this table. - Source - Manual');