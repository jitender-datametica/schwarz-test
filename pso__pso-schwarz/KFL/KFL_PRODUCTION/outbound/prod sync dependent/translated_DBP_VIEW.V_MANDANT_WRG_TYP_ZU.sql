CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mandant_wrg_typ_zu (mandant_id, wrg_typ_id, wrg_id, wrg_typ_bez,
td_update, td_insert) AS SELECT mandant_id,
 wrg_typ_id,
 wrg_id,
 wrg_typ_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mandant_wrg_typ_zu;