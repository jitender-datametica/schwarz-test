CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_herst_food_fleisch_2 (hersteller_food_fleisch_id) AS SELECT
 V01.zusatzinfo_sel_id AS hersteller_food_fleisch_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Hersteller Food/Fleischwaren'
UNION ALL
SELECT - 1 AS hersteller_food_fleisch_id
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;