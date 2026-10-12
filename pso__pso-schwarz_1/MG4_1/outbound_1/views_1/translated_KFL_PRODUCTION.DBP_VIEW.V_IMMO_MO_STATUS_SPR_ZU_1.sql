CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mo_status_spr_zu_1 (mandant_id, mo_status_id, spr_id, mo_status_bez
, td_update, td_insert) AS SELECT mandant_id,
 mo_status_id,
 spr_id,
 mo_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mo_status_spr_zu_1;