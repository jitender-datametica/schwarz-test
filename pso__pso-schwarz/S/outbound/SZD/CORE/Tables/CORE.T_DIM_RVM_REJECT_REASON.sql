/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RVM_REJECT_REASON
   generated from Powerdesigner on Freitag, 16. Mai 2025 14:07:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_reject_reason (
reject_reason_source_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The Unique Identifier for the rejection reason for the deposited articles.'),
reject_reason_group_cd BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The Identifier for the group of rejection reasons.'),
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item i.e. refillable, non-refillable'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
reject_reason_source_cd STRING(100) NOT NULL
OPTIONS(description='The free text code for the rejection reason from the source for the deposited articles.'),
reject_reason_source_descr STRING(250) NOT NULL
OPTIONS(description='The description for the rejection reason from the source for the deposited articles.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (reject_reason_source_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Describes the rejection reasons from the source for the deposited articles in a Deposit Machine - Source - S-File from a Deposit Machine');