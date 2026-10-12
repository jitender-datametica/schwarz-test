CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_kursgruppe_spr_zu AS SELECT V1.mandant_id,
 V1.lin_kursgruppe_id,
 MAX(CASE
   WHEN V2.spr_id = 22
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez,
 MAX(CASE
   WHEN V2.spr_id = 22
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_de,
 MAX(CASE
   WHEN V2.spr_id = 124
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_cz,
 MAX(CASE
   WHEN V2.spr_id = 90
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_pl,
 MAX(CASE
   WHEN V2.spr_id = 108
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_sk,
 MAX(CASE
   WHEN V2.spr_id = 65
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_hr,
 MAX(CASE
   WHEN V2.spr_id = 95
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_ro,
 MAX(CASE
   WHEN V2.spr_id = 18
   THEN V2.lin_kursgruppe_bez
   ELSE NULL
   END) AS lin_kursgruppe_bez_bg
FROM kfl_production_dbp_view.v_l_lin_kursgruppe AS V1
 INNER JOIN kfl_production_dbp_view.v_lin_kursgruppe_spr_zu AS V2 ON V1.lin_kursgruppe_id = V2.lin_kursgruppe_id
GROUP BY V1.mandant_id,
 V1.lin_kursgruppe_id;