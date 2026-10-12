/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RVM_REJECT_REASON_GROUP_2
   generated from Powerdesigner on Freitag, 16. Mai 2025 14:08:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_reject_reason_group_2 (
reject_reason_group_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the group of rejection reasons.'),
reject_reason_group_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the group of rejection reasons in German.'),
reject_reason_group_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the group of rejection reasons in German.'),
reject_reason_group_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the group of rejection reasons in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (reject_reason_group_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Describes the groups for rejection reasons for the deposited articles in a Deposit Machine - Source - Manual');