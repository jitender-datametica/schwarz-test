CREATE OR REPLACE TABLE idq_production_zsm.t024e_1 (
mandt STRING(3) NOT NULL,
ekorg STRING(4) NOT NULL,
ekotx STRING(20),
bukrs STRING(4),
txadr STRING(70),
txkop STRING(70),
txfus STRING(70),
txgru STRING(70),
kalse STRING(4),
mkals STRING(6),
bpeff STRING(1),
bukrs_ntr STRING(4),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, ekorg) NOT ENFORCED
);