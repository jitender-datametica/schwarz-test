CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_deposit_rejectlist_2 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
reject_dt DATE NOT NULL OPTIONS(description='The date when the deposit item_2 was rejected.'),
reject_tm TIME NOT NULL OPTIONS(description='The time when the deposit item_2 was rejected.'),
reject_reason_group_id INTEGER NOT NULL
OPTIONS(description='The rejections defined by the customer as groups of similar rejections'),
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item_2 i.e. refillable, non-refillable'),
ean_2 STRING(13) NOT NULL OPTIONS(description='AEuropean article number'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, reject_dt, reject_tm) NOT ENFORCED
);