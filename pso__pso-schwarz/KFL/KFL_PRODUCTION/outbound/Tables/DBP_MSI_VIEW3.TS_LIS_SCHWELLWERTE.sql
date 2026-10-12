CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view3.ts_lis_schwellwerte (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
schwellwert_typ_bez STRING(50) COLLATE 'und:ci' NOT NULL,
schwellwert NUMERIC(9,2) NOT NULL
);