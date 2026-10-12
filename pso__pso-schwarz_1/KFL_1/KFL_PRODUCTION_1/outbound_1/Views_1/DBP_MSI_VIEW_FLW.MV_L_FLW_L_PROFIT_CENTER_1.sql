CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_profit_center_1 (pc_id, krk_id, mandant_id, wup_id,
nb_id, werk_id) AS SELECT pc_id,
 krk_id,
 mandant_id,
 wup_id,
 nb_id,
 werk_id
FROM kfl_production_dbp_view.v_profit_center_1
WHERE mandant_id IN (1, 2);