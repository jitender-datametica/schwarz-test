DROP TABLE IF EXISTS dbp_msi_view_rpw_materialized.mv_spanne_wb_lbd_2;
CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_spanne_wb_lbd_2 (
dat DATE,
beleg_wb_id INTEGER,
beleg_wb_pos_id INTEGER,
mandant_id INTEGER,
system_id INTEGER,
abs_id INTEGER,
rcv_id INTEGER,
art_id INTEGER,
bew_art_wb_id STRING(3) COLLATE 'und:ci',
vk_brutto BIGNUMERIC(38,12),
ek_netto NUMERIC(29,4),
ek_netto_hyb BIGNUMERIC(38,11),
mwst NUMERIC(29,2),
mwst_id INTEGER,
spanne_wb_herkunft_id INTEGER,
menge NUMERIC(29,3),
belastungsart_id STRING(3) COLLATE 'und:ci',
belastungsart_vd_id INTEGER
) CLUSTER BY mandant_id, system_id, dat, art_id;