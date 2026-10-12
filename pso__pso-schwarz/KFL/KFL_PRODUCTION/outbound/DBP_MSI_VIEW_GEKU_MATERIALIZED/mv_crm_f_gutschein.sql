CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_crm_f_gutschein (
crm_gutschein_id STRING(36) COLLATE 'und:ci',
crm_vorgang_id STRING(36) COLLATE 'und:ci',
crm_gutschein_grund_id INTEGER,
gutschein_nummer STRING(100) COLLATE 'und:ci',
kostenstelle_id STRING(100) COLLATE 'und:ci',
mandant_id INTEGER,
gutschein_wert NUMERIC(29,2),
dat_start DATE,
dat_ende DATE,
dat_start_processing DATE,
dat_end_processing DATE,
sec_kz INTEGER
);