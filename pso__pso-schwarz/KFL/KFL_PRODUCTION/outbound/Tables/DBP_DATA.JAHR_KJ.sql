CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.jahr_kj (
kj BIGNUMERIC(38,0),
akt_kj BIGNUMERIC(38,0),
akt_kj_komplett BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP1_MIS - Kalenderjahr');