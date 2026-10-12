CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_hauptbereich_spr_zu_2 AS SELECT AMX.hauptbereich_id,
 AMX.invers_ber_id,
 MAX(CASE
   WHEN MCX.spr_id = 22
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez,
 MAX(CASE
   WHEN MCX.spr_id = 22
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez,
 MAX(CASE
   WHEN MCX.spr_id = 124
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_cz,
 MAX(CASE
   WHEN MCX.spr_id = 124
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_cz,
 MAX(CASE
   WHEN MCX.spr_id = 108
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_sk,
 MAX(CASE
   WHEN MCX.spr_id = 108
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_sk,
 MAX(CASE
   WHEN MCX.spr_id = 65
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_hr,
 MAX(CASE
   WHEN MCX.spr_id = 65
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_hr,
 MAX(CASE
   WHEN MCX.spr_id = 90
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_pl,
 MAX(CASE
   WHEN MCX.spr_id = 90
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_pl,
 MAX(CASE
   WHEN MCX.spr_id = 95
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_ro,
 MAX(CASE
   WHEN MCX.spr_id = 95
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_ro,
 MAX(CASE
   WHEN MCX.spr_id = 18
   THEN MCX.invers_ber_bez
   ELSE NULL
   END) AS hauptbereich_bez_bg,
 MAX(CASE
   WHEN MCX.spr_id = 18
   THEN MCX.invers_ber_bez_2
   ELSE NULL
   END) AS hauptbereich_kbez_bg
FROM kfl_production_dbp_view.v_amx_hauptbereich_mcx_invers_bereich_zu_2 AS AMX
 LEFT JOIN kfl_production_dbp_view.v_mcx_invers_bereich_spr_zu_2 AS MCX ON AMX.invers_ber_id = MCX.invers_ber_id
WHERE AMX.amx_system_id = 1
GROUP BY AMX.hauptbereich_id,
 AMX.invers_ber_id;