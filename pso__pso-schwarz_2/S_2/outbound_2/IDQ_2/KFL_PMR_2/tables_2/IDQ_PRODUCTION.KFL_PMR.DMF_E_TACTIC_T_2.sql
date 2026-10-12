CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_e_tactic_t_2 (
client STRING(3) NOT NULL,
tactic_type STRING(4) NOT NULL,
tactic FLOAT64,
language STRING(1),
tactic_desc STRING(255),
zzpmr_ktext STRING(255),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (client, tactic_type) NOT ENFORCED
);