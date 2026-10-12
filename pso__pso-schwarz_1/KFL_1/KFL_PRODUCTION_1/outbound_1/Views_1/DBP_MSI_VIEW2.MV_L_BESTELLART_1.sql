CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_bestellart_1 AS SELECT mandant_id,
 bestellart_id,
 bestellart_bez
FROM kfl_production_dbp_view.v_bestellart_spr_zu_1
WHERE mandant_id = 1;