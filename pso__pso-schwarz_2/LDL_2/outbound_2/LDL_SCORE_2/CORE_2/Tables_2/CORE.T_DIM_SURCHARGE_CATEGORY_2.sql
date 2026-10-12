--==============================================================
-- Table: t_dim_surcharge_category_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_surcharge_category_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 14:02:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_surcharge_category_2 (
surcharge_categ_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
surcharge_categ_name STRING(100) NOT NULL
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type.'),
surcharge_categ_name_de STRING(100)
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type (in German).'),
surcharge_categ_name_en STRING(100)
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type (in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (surcharge_categ_cd) NOT ENFORCED
)
OPTIONS(description='This dimension defines the surcharge categories, Surcharge Category is a grouping of several Surcharge types.');