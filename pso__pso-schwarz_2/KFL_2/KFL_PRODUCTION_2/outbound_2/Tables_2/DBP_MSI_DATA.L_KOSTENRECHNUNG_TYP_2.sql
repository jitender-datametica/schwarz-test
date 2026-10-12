CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.l_kostenrechnung_typ_2 (
kostenrechnung_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kostenrechnung_typ_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);