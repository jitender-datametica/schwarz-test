CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_besitzstatus_spr_zu AS SELECT mandant_id,
 besitzstatus_id,
 spr_id,
 besitzstatus_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_besitzstatus_spr_zu;