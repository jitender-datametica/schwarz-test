CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjwo_ww BIGNUMERIC(38,0) NOT NULL,
kommentar STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
);