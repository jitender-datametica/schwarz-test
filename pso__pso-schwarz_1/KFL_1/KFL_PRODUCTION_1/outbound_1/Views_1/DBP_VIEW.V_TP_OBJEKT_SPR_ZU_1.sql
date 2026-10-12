CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_objekt_spr_zu_1 AS SELECT mandant_id,
 tp_objekt_id,
 spr_id,
 tp_objekt_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.tp_objekt_spr_zu_1;