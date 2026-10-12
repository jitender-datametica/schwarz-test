CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_spanne_wb_bld (
dat DATE,
beleg_wb_id INTEGER,
beleg_wb_pos_id INTEGER,
mandant_id INTEGER,
system_id INTEGER,
abs_id INTEGER,
rcv_id INTEGER,
art_id INTEGER,
bew_art_wb_id STRING(4) COLLATE 'und:ci',
belastungsart_id STRING(4) COLLATE 'und:ci',
belastungsart_vd_id INTEGER,
vk_brutto NUMERIC(29,3),
ek_netto NUMERIC(29,3),
mwst NUMERIC(29,2),
mwst_id INTEGER,
spanne_wb_herkunft_id INTEGER,
menge NUMERIC(29,3)
);