CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vs_1 AS SELECT vs_id,
 mandant_id,
 vk_id,
 vs_bez,
 vsvt_bez,
 vs_ref_wup_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.vs_1;