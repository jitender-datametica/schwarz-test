CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t315_batches_1 (wawi_instanz_kzl, c315_batchid,
c315_state, c315_moddate, c315_moduser, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c315_batchid,
 c315_state,
 c315_moddate,
 c315_moduser,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t315_batches_1;