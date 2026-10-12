CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_testart_spr_zu_1 AS SELECT CASE
  WHEN teku_attribut_id = 43
  THEN 1
  WHEN teku_attribut_id = 297
  THEN 0
  ELSE NULL
  END AS frische_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN teku_attribut_bez
   ELSE NULL
   END) AS frische_fg_bez_bg
FROM kfl_production_dbp_msi_v_view.v_l_teku_attribut_1
WHERE teku_attribut_id IN (43, 297)
GROUP BY frische_fg;