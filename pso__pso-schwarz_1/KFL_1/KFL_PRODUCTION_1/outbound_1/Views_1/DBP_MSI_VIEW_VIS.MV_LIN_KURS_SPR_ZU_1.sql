CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_kurs_spr_zu_1 (mandant_id, lin_kurs_id, lin_kurs_bez,
lin_kurs_bez_de, lin_kurs_bez_cz, lin_kurs_bez_pl, lin_kurs_bez_sk, lin_kurs_bez_hr, lin_kurs_bez_ro, lin_kurs_bez_bg)
AS SELECT V1.mandant_id,
 V1.lin_kurs_id,
 MAX(CASE
   WHEN V2.spr_id = 22
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez,
 MAX(CASE
   WHEN V2.spr_id = 22
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_de,
 MAX(CASE
   WHEN V2.spr_id = 124
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_cz,
 MAX(CASE
   WHEN V2.spr_id = 90
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_pl,
 MAX(CASE
   WHEN V2.spr_id = 108
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_sk,
 MAX(CASE
   WHEN V2.spr_id = 65
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_hr,
 MAX(CASE
   WHEN V2.spr_id = 95
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_ro,
 MAX(CASE
   WHEN V2.spr_id = 18
   THEN V2.lin_kurs_bez
   ELSE V1.lin_kurs_id
   END) AS lin_kurs_bez_bg
FROM kfl_production_dbp_view.v_lin_kurs_spr_zu_1 AS V1
 INNER JOIN kfl_production_dbp_view.v_lin_kurs_spr_zu_1 AS V2 ON V1.lin_kurs_id = V2.lin_kurs_id
WHERE V1.lin_bericht <> 'PRG'
 AND V2.lin_bericht <> 'PRG'
GROUP BY V1.mandant_id,
 V1.lin_kurs_id;