CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_ebene_4_spr_zu_2 (geku_artikel_id, geku_dwh_artikel_id,
geku_artikel_bez, geku_artikel_bez_cz, geku_artikel_bez_pl, geku_artikel_bez_sk, geku_artikel_bez_hr,
geku_artikel_bez_ro, geku_artikel_bez_bg) AS SELECT V01.geku_artikel_id,
 V01.geku_dwh_artikel_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_bg
FROM kfl_production_dbp_view.v_l_geku_artikel_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_geku_dwh_artikel_2 AS V02 ON V01.geku_dwh_artikel_id = V02.geku_dwh_artikel_id
 INNER JOIN kfl_production_dbp_view.v_geku_artikel_spr_zu_2 AS V03 ON V02.geku_artikel_uid = V03.geku_artikel_uid
GROUP BY V01.geku_artikel_id,
 V01.geku_dwh_artikel_id;