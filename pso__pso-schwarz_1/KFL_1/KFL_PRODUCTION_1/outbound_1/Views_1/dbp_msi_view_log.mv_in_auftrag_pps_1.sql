CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_auftrag_pps_1 (auftrag_id, mandant_id, dat_start,
auftrag_rm_id, auftrag_rm_pos_id, dat_planaufloesung) AS SELECT auftrag_id,
 mandant_id,
 dat_start,
 auftrag_rm_id,
 auftrag_rm_pos_id,
 dat_planaufloesung
FROM kfl_production_dbp_view.v_in_auftrag_pps_1 AS V01;