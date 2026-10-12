CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_aktiv_kz_zu (mandant_id, art_id, aktiv_kz) AS SELECT V01.mandant_id
 ,
 V01.art_id,
 COALESCE(v03.aktiv_kz, 'k.A.') AS aktiv_kz
FROM kfl_production_dbp_view.v_art AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
    CASE
    WHEN SUM(anzahl_markt_listung) = 0
    THEN ' '
    WHEN SUM(anzahl_markt_listung) > 0
    THEN 'X'
    ELSE NULL
    END AS aktiv_kz
  FROM kfl_production_dbp_view.v_sternchen_logik AS V02
  GROUP BY mandant_id,
   art_id) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.art_id = v03.art_id
GROUP BY V01.mandant_id,
 V01.art_id,
 aktiv_kz;