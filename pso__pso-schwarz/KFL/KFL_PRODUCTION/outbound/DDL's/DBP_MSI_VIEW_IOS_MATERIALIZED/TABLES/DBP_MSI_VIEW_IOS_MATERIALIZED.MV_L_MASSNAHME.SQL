CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_l_massnahme (
massnahme_id STRING(20) COLLATE 'und:ci',
massnahmenart_id INTEGER,
massnahmenart_bez STRING(40) COLLATE 'und:ci',
massnahme_akt_fg INTEGER,
massnahmen_gruppe_id INTEGER,
massnahmen_gruppe STRING(16777216)
);