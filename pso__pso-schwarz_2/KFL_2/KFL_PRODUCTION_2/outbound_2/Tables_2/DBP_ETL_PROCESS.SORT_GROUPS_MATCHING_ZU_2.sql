CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.sort_groups_matching_zu_2 (
mandant_id BIGNUMERIC(38,0),
art_matching_id BIGNUMERIC(38,0),
art_gruppe_id BIGNUMERIC(38,0),
art_gruppe_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);