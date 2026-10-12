CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_rejection_reason_1 (
reject_reason_id INTEGER NOT NULL OPTIONS(description='The code for the rejection reason of deposits.'),
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item_1 i.e. refillable, non-refillable'),
reject_reason_group_id INTEGER NOT NULL
OPTIONS(description='The rejections defined by the customer as groups of similar rejections'),
reject_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the rejection reason in German.'),
reject_reason_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the rejection reason in English.'),
reject_reason_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the rejection reason in German.'),
reject_reason_source_nr STRING(100)
OPTIONS(description='A textual description for the rejection reason coming from the source.'),
reject_reason_source_name STRING(100)
OPTIONS(description='A textual description for the rejection reason coming from the source.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (reject_reason_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the rejection reasons of items');