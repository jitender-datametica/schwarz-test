CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_debitor_status AS SELECT mandant_id,
 debitor_status_id,
 debitor_status_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_debitor_status
WHERE spr_id = 22;