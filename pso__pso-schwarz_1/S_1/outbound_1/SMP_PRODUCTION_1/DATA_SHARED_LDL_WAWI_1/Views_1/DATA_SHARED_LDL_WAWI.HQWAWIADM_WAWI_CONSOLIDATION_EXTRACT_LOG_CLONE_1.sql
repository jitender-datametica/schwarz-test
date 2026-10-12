CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_wawi_consolidation_extract_log_clone_1 (wawi_instanz_kzl
, wh_nr, table_name, max_scn, created_tmsp, updated_tmsp, max_dfg_scn) AS SELECT wawi_instanz_kzl,
 wh_nr,
 table_name,
 max_scn,
 created_tmsp,
 updated_tmsp,
 max_dfg_scn
FROM ldl_wawi_production_hqwawiadm.wawi_consolidation_extract_log_clone_1;