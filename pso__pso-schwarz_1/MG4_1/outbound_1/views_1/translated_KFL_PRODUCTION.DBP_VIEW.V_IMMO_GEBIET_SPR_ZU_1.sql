CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_gebiet_spr_zu_1 (mandant_id, gebiet_id, spr_id, gebiet_bez,
td_update, td_insert) AS SELECT mandant_id,
 gebiet_id,
 spr_id,
 gebiet_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_gebiet_spr_zu_1;