CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_lager_bewart_spr_zu (lager_bewart_id, bewart_bez, mandant_id
, spr_id, system_id) AS SELECT lager_bewart_id,
 lager_bewart_bez AS bewart_bez,
 mandant_id,
 spr_id,
 system_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu AS V01
WHERE system_id NOT IN (2, 17, 28, 32, 48, 53);