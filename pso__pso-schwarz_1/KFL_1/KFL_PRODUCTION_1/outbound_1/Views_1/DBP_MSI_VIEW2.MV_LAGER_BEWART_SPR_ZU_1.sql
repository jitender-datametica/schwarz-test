CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_lager_bewart_spr_zu_1 (lager_bewart_id, bewart_bez, mandant_id,
spr_id) AS SELECT lager_bewart_id,
 lager_bewart_bez AS bewart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu_1 AS V01
WHERE mandant_id = 1
 AND spr_id = 22
 AND system_id NOT IN (2, 17, 28, 32, 48, 53);