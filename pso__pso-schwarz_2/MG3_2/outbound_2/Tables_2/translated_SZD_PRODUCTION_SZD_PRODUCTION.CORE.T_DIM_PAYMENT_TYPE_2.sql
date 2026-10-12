CREATE OR REPLACE TABLE szd_production_core.t_dim_payment_type_2 (
payment_type_id INTEGER NOT NULL OPTIONS(description='The identifier for a chosen payment type'),
payment_type_descr STRING(250) NOT NULL
OPTIONS(description='The default textual description for the payment type for a hot beverage.'),
payment_type_descr_de STRING(250) NOT NULL
OPTIONS(description='The German description for the payment type for a hot beverage'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
payment_type_descr_en STRING(250) NOT NULL
OPTIONS(description='The English description for the payment type for a hot beverage.'),
PRIMARY KEY (payment_type_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the payment types for hot beverage products');