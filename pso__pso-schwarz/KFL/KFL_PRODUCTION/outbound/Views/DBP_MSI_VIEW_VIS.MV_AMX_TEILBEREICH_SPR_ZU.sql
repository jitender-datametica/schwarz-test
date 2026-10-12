CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_teilbereich_spr_zu AS SELECT AMX.teilbereich_id,
 AMX.invers_kat_id,
 MAX(CASE
   WHEN MCX.spr_id = 22
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez,
 MAX(CASE
   WHEN MCX.spr_id = 22
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez,
 MAX(CASE
   WHEN MCX.spr_id = 124
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_cz,
 MAX(CASE
   WHEN MCX.spr_id = 124
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_cz,
 MAX(CASE
   WHEN MCX.spr_id = 108
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_sk,
 MAX(CASE
   WHEN MCX.spr_id = 108
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_sk,
 MAX(CASE
   WHEN MCX.spr_id = 65
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_hr,
 MAX(CASE
   WHEN MCX.spr_id = 22
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_hr,
 MAX(CASE
   WHEN MCX.spr_id = 90
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_pl,
 MAX(CASE
   WHEN MCX.spr_id = 90
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_pl,
 MAX(CASE
   WHEN MCX.spr_id = 95
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_ro,
 MAX(CASE
   WHEN MCX.spr_id = 95
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_ro,
 MAX(CASE
   WHEN MCX.spr_id = 18
   THEN MCX.invers_kat_bez
   ELSE NULL
   END) AS teilbereich_bez_bg,
 MAX(CASE
   WHEN MCX.spr_id = 18
   THEN MCX.invers_kat_bez_2
   ELSE NULL
   END) AS teilbereich_kbez_bg
FROM kfl_production_dbp_view.v_amx_teilbereich_mcx_invers_kategorie_zu AS AMX
 LEFT JOIN kfl_production_dbp_view.v_mcx_invers_kategorie_spr_zu AS MCX ON AMX.invers_kat_id = MCX.invers_kat_id
WHERE AMX.amx_system_id = 1
GROUP BY AMX.teilbereich_id,
 AMX.invers_kat_id;