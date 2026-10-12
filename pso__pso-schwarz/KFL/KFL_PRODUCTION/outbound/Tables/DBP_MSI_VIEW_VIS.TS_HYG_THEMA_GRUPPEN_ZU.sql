CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_vis.ts_hyg_thema_gruppen_zu (
hyg_thema_id STRING(36) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
hyg_thema_gruppe_id BIGNUMERIC(38,0) NOT NULL,
hyg_thema_gruppe_mutter_id BIGNUMERIC(38,0) NOT NULL
);