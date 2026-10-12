CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_foto_fg_spr_zu (foto_fg, foto_fg_bez, foto_fg_bez_cz,
foto_fg_bez_pl, foto_fg_bez_sk, foto_fg_bez_hr, foto_fg_bez_ro, foto_fg_bez_bg) AS SELECT flag AS foto_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN flag_bez
   ELSE NULL
   END) AS foto_fg_bez_bg
FROM kfl_production_dbp_data.flag_spr_zu AS V01
WHERE flag_typ_id = 1
GROUP BY foto_fg;