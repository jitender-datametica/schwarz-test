CREATE TABLE IF NOT EXISTS szd_core.t_fact_deposit_reject_per_day_2 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
reject_dt DATE NOT NULL OPTIONS(description='The date when the deposit item_2 was rejected.'),
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item_2 i.e. refillable, non-refillable'),
reject_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number for the item_2 rejections.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, reject_dt, deposit_item_cat_cd) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing deposit machines rejecting items');