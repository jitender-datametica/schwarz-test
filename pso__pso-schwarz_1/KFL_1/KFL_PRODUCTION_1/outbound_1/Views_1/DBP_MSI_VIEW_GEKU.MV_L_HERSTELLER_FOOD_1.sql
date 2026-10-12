CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_hersteller_food_1 (hersteller_food_id) AS SELECT V01.zusatzinfo_sel_id
  AS hersteller_food_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Hersteller Food'
UNION ALL
SELECT - 1 AS hersteller_food_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;