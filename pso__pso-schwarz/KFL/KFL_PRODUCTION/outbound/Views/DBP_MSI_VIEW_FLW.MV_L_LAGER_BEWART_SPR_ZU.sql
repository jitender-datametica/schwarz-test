CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_lager_bewart_spr_zu (lager_bewart_id, lager_bewart_bez,
mandant_id) AS SELECT V01.lager_bewart_id,
 V01.lager_bewart_bez,
 V01.mandant_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);