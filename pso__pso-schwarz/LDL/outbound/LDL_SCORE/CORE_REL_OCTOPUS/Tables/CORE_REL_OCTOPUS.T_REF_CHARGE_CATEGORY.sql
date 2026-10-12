CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_charge_category (
charge_categ_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
charge_categ_name STRING(100) NOT NULL
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type.'),
charge_categ_name_de STRING(100)
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type (in German).'),
charge_categ_name_en STRING(100)
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type (in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (charge_categ_cd) NOT ENFORCED
)
OPTIONS(description='This table defines the charge categories, Charge Category is a grouping of several charge types.');