CREATE OR REPLACE TABLE szd_production_core.t_dim_hga_mug_type (
mug_type_id INTEGER NOT NULL OPTIONS(description='The identifier for a chosen mug type'),
mug_type_descr STRING(250) NOT NULL OPTIONS(description='The default textual description for the mug type'),
mug_type_descr_de STRING(250) NOT NULL OPTIONS(description='The textual description for the mug type in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
mug_type_descr_en STRING(250) NOT NULL OPTIONS(description='The textual description for the mug type in English.'),
PRIMARY KEY (mug_type_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the mug types for hot beverage products');