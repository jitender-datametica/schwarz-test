CREATE OR REPLACE TABLE szd_production_fe_mstr_lifecycle.ts_dim_rvm_deact_2 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
rvm_active_id INTEGER NOT NULL OPTIONS(description='The ID which is set by the MSTR Transaction Service Report'),
inactive_dt DATE NOT NULL
OPTIONS(description='The date when the machine was inactivated, set by MSTR Transaction Service Report.'),
inserted_tmsp DATETIME NOT NULL
OPTIONS(description='The date, the entry was technically inserted by the MSTR Transaction Service Report'),
PRIMARY KEY (rvm_sid, inserted_tmsp) NOT ENFORCED
) OPTIONS(description='Data from the MSTR Transaction Service Report');