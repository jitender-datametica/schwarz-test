CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kurs_2 (
kurstyp_id BIGNUMERIC(38,0) NOT NULL,
von_wrg_id STRING(12) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
umrechnungskurs BIGNUMERIC(38,5) NOT NULL,
nach_wrg_id STRING(12) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Umrechnungskurse zwischen den im DWH vorkommenden Währungen, historisiert');