CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_aktiv_kz_zu_2 (mandant_id, art_id, aktiv_kz) AS
-- WHERE V02.MANDANT_ID <> 1
 SELECT V01.mandant_id,
 V01.art_id,
 COALESCE(V03.aktiv_kz, 'K.A.') AS aktiv_kz
FROM kfl_production_dbp_view.v_art_2 AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
    CASE
    WHEN SUM(anzahl_markt_listung) = 0
    THEN ' '
    WHEN SUM(anzahl_markt_listung) > 0
    THEN 'X'
    ELSE NULL
    END AS aktiv_kz
  FROM kfl_production_dbp_view.v_sternchen_logik_2 AS V02
  GROUP BY mandant_id,
   art_id) AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id -- WHERE V01.MANDANT_ID <> 1

GROUP BY V01.mandant_id,
 V01.art_id,
 aktiv_kz;