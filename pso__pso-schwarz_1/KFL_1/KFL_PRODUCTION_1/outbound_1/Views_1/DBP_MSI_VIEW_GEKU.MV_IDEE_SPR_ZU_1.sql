CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_idee_spr_zu_1 (idee_fg, idee_bez, idee_bez_cz, idee_bez_pl,
idee_bez_sk, idee_bez_hr, idee_bez_ro, idee_bez_bg) AS SELECT flag AS idee_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN flag_bez
   ELSE NULL
   END) AS idee_bez_bg
FROM kfl_production_dbp_view.v_flag_spr_zu_1 AS V01
WHERE flag_typ_id = 1
GROUP BY idee_fg;