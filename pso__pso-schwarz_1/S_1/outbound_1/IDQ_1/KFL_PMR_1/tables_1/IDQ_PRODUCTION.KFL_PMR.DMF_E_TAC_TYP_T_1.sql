CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_e_tac_typ_t_1 (
client STRING(3) NOT NULL,
tactic_type STRING(4) NOT NULL,
language STRING(1),
tactic_type_desc STRING(255),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (client, tactic_type) NOT ENFORCED
);