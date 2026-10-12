CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_abt_spr_zu_1 AS SELECT abt_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN abt_bez
   ELSE NULL
   END) AS abt_bez_bg
FROM kfl_production_dbp_view.v_abt_spr_zu_1
WHERE arthiertyp_id = 2
GROUP BY abt_id;