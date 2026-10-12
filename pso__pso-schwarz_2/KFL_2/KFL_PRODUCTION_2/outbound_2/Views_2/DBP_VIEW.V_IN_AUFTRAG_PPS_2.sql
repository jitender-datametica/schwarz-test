CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_auftrag_pps_2 AS SELECT auftrag_id,
 mandant_id,
 dat_start,
 auftrag_rm_id,
 auftrag_rm_pos_id,
 dat_planaufloesung,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_auftrag_pps_2;