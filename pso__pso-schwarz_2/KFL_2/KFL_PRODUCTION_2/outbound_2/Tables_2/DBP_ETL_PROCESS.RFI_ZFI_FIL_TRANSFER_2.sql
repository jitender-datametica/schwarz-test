CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.rfi_zfi_fil_transfer_2 (
mandant_id BIGNUMERIC(38,0),
buchungskreis_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
buchungskreis_id_neu BIGNUMERIC(38,0),
wup_id_neu BIGNUMERIC(38,0),
dat_von DATE,
dat_bis DATE,
wup_aenderung_grund_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP,
rfi_bez STRING(200)
);