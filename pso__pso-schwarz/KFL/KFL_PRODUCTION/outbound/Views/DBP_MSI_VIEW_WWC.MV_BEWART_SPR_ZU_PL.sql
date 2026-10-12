CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_bewart_spr_zu_pl (mandant_id, bwart, lager_bewart_bez, spr_id
) AS SELECT mandant_id,
 lager_bewart_id AS bwart,
 lager_bewart_bez,
 spr_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu AS V01
WHERE spr_id = 90;