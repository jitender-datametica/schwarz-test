CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_fremdkoerper_fg_spr_zu_2 AS SELECT flag AS fremdkoerper_fg
 ,
 MAX(CASE
   WHEN spr_id = 22
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN flag_bez
   ELSE NULL
   END) AS fremdkoerper_fg_bez_bg
FROM kfl_production_dbp_view.v_flag_spr_zu_2 AS V01
WHERE flag_typ_id = 1
GROUP BY fremdkoerper_fg;