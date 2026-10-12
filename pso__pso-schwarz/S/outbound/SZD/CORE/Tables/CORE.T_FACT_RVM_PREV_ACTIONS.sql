CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_prev_actions (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
prev_action_dt DATE NOT NULL
OPTIONS(description='The date when preventive maintenance was carried out on the deposit machine.'),
prev_action_tm TIME NOT NULL
OPTIONS(description='The time when preventive maintenance was carried out on the deposit machine.'),
rvm_prev_action_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code defining the type of preventive maintenance activity for a deposit machine.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
PRIMARY KEY (rvm_sid, prev_action_dt, prev_action_tm) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing preventive maintenance operations of deposit machines.');