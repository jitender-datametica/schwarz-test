-- standard=deutsch
 -- 01.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_stichwort_spr_zu_2 (geku_stichwort_uid, geku_stichwort_bez,
geku_stichwort_bez_cz, geku_stichwort_bez_pl, geku_stichwort_bez_sk, geku_stichwort_bez_hr, geku_stichwort_bez_ro,
geku_stichwort_bez_bg) AS SELECT geku_stichwort_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_stichwort_bez
   ELSE NULL
   END) AS geku_stichwort_bez_bg
FROM kfl_production_dbp_view.v_geku_stichwort_spr_zu_2 AS v01
GROUP BY geku_stichwort_uid;