CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_objekt_status_spr_zu_2 AS SELECT mandant_id,
 tp_objekt_status_id,
 spr_id,
 tp_objekt_status_kbez,
 tp_objekt_status_bez
FROM kfl_production_dbp_data.tp_objekt_status_spr_zu_2;