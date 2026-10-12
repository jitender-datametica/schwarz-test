CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktionsart_liste_spr_zu_2 (mandant_id, aktionsart_liste_id,
aktionsart_liste_bez) AS SELECT mandant_id,
 aktionsart_liste_id,
 aktionsart_liste_bez
FROM kfl_production_dbp_view.v_aktionsart_liste_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;