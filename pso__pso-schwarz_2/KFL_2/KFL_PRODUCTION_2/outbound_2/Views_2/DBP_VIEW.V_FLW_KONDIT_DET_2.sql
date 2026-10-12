CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kondit_det_2 AS SELECT mandant_id,
 kondition_id,
 kondition_pos_id,
 kondition_applikation_id,
 konditionsart_id,
 betrag_kondition,
 kondition_einh_id,
 kondition_preis_einh_id,
 kondition_menge_einh_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kondit_det_2;