CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_aktionthema_1
 AS
WITH RANKED_AKTIONEN AS (SELECT V01.mandant_id,
   V01.aktion_id,
   V01.art_id,
   V03.kl_art_id,
   V01.aktion_thema_id,
   V01.vk_aktion_brutto,
   V02.preisaktiviert_fg,
   V02.werbe_kat_id,
   V02.aktionsart_id,
   V02.dat_von,
   V02.dat_bis,
   V04.kjwo_ww,
   COUNT(*) AS anzahl,
   ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.aktion_id, V01.art_id ORDER BY COUNT(*) DESC NULLS FIRST) AS rank
   
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_aktion_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.aktion_id = V02.aktion_id
     
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id AND
     V03.dat_bis = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS V04 ON V02.mandant_id = V04.mandant_id AND V02.dat_von = V04.dat
     
  WHERE V01.nb_id = 0
   AND V02.dat_bis >= DATE '2019-01-01'
   AND V01.mandant_id = 1
  GROUP BY V01.mandant_id,
   V01.aktion_id,
   V01.art_id,
   V01.vk_aktion_brutto,
   V01.aktion_thema_id,
   V02.aktionsart_id,
   V02.werbe_kat_id,
   V02.dat_von,
   V02.dat_bis,
   V02.preisaktiviert_fg,
   V03.kl_art_id,
   V04.kjwo_ww) (SELECT *
  FROM (SELECT mandant_id,
      aktion_id,
      art_id,
      kl_art_id,
      aktion_thema_id,
      vk_aktion_brutto,
      preisaktiviert_fg,
      werbe_kat_id,
      aktionsart_id,
      dat_von,
      dat_bis,
      kjwo_ww
     FROM RANKED_AKTIONEN
     WHERE rank = 1
     UNION DISTINCT
     (SELECT V010.mandant_id,
       V010.aktion_id,
       CAST(NULL AS INTEGER) AS art_id,
       CAST(NULL AS INTEGER) AS kl_art_id,
       'nicht vorhanden' AS aktion_thema_id,
       CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
       CAST(NULL AS INTEGER) AS preisaktiviert_fg,
       CAST(NULL AS INTEGER) AS werbe_kat_id,
       CAST(NULL AS STRING) AS aktionsart_id,
       V010.dat_von,
       V010.dat_bis,
       V040.kjwo_ww
      FROM kfl_production_dbp_view.v_l_bonuskauf_1 AS V010
       INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS V040 ON V010.mandant_id = V040.mandant_id AND V010.dat_von
         = V040.dat
      WHERE V010.dat_bis >= DATE '2019-01-01'
       AND V010.mandant_id = 1
       AND (V010.mandant_id, V010.aktion_id) NOT IN (SELECT (V011.mandant_id, V011.aktion_id)
         FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS V011
          INNER JOIN kfl_production_dbp_view.v_aktion_1 AS V020 ON V011.mandant_id = V020.mandant_id AND V011.aktion_id =
            V020.aktion_id
          INNER JOIN kfl_production_dbp_view.v_art_1 AS V030 ON V011.mandant_id = V030.mandant_id AND V011.art_id = V030.art_id
               AND V030.dat_bis = DATE '9999-12-31' AND V020.dat_bis >= DATE '2019-01-01'
         WHERE V011.nb_id = 0
          AND V011.mandant_id = 1
         GROUP BY V011.mandant_id,
          V011.aktion_id)
      UNION DISTINCT
      SELECT mandant_id,
       '' AS aktion_id,
       art_id,
       kl_art_id,
       'nicht vorhanden' AS aktion_thema_id,
       CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
       CAST(NULL AS INTEGER) AS preisaktiviert_fg,
       CAST(NULL AS INTEGER) AS werbe_kat_id,
       CAST(NULL AS STRING) AS aktionsart_id,
       CAST(NULL AS DATE) AS dat_von,
       CAST(NULL AS DATE) AS dat_bis,
       CAST(NULL AS INTEGER) AS kjwo_ww
      FROM kfl_production_dbp_view.v_art_1 AS V01
      WHERE dat_bis = DATE '9999-12-31'
       AND mandant_id = 1))
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST,
   3 NULLS LAST);