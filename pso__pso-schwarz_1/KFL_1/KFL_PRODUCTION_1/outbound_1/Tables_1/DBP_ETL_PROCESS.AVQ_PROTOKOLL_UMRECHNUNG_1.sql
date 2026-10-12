CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.avq_protokoll_umrechnung_1 (
kjwo BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
komponente_art_id BIGNUMERIC(38,0),
komponentenmenge_einh_id STRING(3) COLLATE 'und:ci',
stueckliste_id BIGNUMERIC(38,0)
);