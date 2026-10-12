CREATE OR REPLACE TABLE kfl_production_dbp_data.kurs_1 (
kurstyp_id INTEGER NOT NULL,
von_wrg_id STRING(12) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
umrechnungskurs NUMERIC(29,5) NOT NULL,
nach_wrg_id STRING(12) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Umrechnungskurse zwischen den im DWH vorkommenden Währungen, historisiert');