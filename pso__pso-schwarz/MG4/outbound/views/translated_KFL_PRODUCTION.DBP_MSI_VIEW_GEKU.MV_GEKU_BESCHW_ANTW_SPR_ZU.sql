-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_beschw_antw_spr_zu (beschwerde_antwort_id, beschwerde_antw_bez,
beschwerde_antw_bez_cz, beschwerde_antw_bez_pl, beschwerde_antw_bez_sk, beschwerde_antw_bez_hr, beschwerde_antw_bez_ro,
beschwerde_antw_bez_bg) AS SELECT beschwerde_antwort_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN beschwerde_antw_bez
   ELSE NULL
   END) AS beschwerde_antw_bez_bg
FROM kfl_production_dbp_view.v_geku_beschw_antw_spr_zu AS v01
GROUP BY beschwerde_antwort_id;