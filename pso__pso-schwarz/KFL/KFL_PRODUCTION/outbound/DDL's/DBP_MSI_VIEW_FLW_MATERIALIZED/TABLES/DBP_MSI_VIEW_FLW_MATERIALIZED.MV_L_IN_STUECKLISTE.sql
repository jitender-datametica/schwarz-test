CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_stueckliste (
mandant_id INTEGER,
stueckliste_id INTEGER,
stueckliste_typ_id STRING(1) COLLATE 'und:ci',
in_art_id INTEGER,
werk_id INTEGER,
menge_basis NUMERIC(29,3)
);