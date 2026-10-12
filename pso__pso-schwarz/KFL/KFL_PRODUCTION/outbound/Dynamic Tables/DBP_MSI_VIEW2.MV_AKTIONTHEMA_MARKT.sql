CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_aktionthema_markt
OPTIONS(max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT DISTINCT V01.mandant_id,
 V01.aktion_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V03.kl_art_id,
 V01.aktion_thema_id,
 V01.vk_aktion_brutto,
 V02.preisaktiviert_fg,
 V02.werbe_kat_id,
 V02.aktionsart_id,
 V02.dat_von,
 V02.dat_bis,
 V04.kjwo_ww
FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_aktion AS V02 ON V01.mandant_id = V02.mandant_id AND V01.aktion_id = V02.aktion_id
   
 INNER JOIN kfl_production_dbp_view.v_art AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
 INNER JOIN kfl_production_dbp_view.v_werbewoche_kl AS V04 ON V02.mandant_id = V04.mandant_id AND V02.dat_von = V04.dat
WHERE V01.nb_id = 0
 AND V03.dat_bis = DATE '9999-12-31'
 AND V02.dat_bis >= DATE '2019-01-01'
 AND V01.mandant_id = 1
UNION DISTINCT
(SELECT V040.mandant_id,
  V040.aktion_id,
  CAST(NULL AS INTEGER) AS wup_id,
  CAST(NULL AS INTEGER) AS nb_id,
  CAST(NULL AS INTEGER) AS art_id,
  CAST(NULL AS INTEGER) AS kl_art_id,
  'nicht vorhanden' AS aktion_thema_id,
  CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
  CAST(NULL AS INTEGER) AS preisaktiviert_fg,
  CAST(NULL AS INTEGER) AS werbe_kat_id,
  SUBSTR(CAST(NULL AS STRING), 1, 4) AS aktionsart_id,
  V040.dat_von,
  V040.dat_bis,
  V05.kjwo_ww
 FROM kfl_production_dbp_view.v_l_bonuskauf AS V040
  INNER JOIN kfl_production_dbp_view.v_werbewoche_kl AS V05 ON V040.mandant_id = V05.mandant_id AND V040.dat_von = V05.dat
    
 WHERE V040.dat_bis >= DATE '2019-01-01'
  AND V040.mandant_id = 1
  AND (V040.mandant_id, V040.aktion_id) NOT IN (SELECT (A.mandant_id, A.aktion_id)
    FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS A
     INNER JOIN kfl_production_dbp_view.v_aktion AS B ON A.mandant_id = B.mandant_id AND A.aktion_id = B.aktion_id
     INNER JOIN kfl_production_dbp_view.v_art AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
    WHERE A.nb_id = 0
     AND C.dat_bis = DATE '9999-12-31'
     AND B.dat_bis >= DATE '2019-01-01'
     AND A.mandant_id = 1
    GROUP BY A.mandant_id,
     A.aktion_id)
 GROUP BY V040.mandant_id,
  V040.aktion_id,
  wup_id,
  nb_id,
  art_id,
  kl_art_id,
  aktion_thema_id,
  vk_aktion_brutto,
  preisaktiviert_fg,
  werbe_kat_id,
  aktionsart_id,
  V040.dat_von,
  V040.dat_bis,
  V05.kjwo_ww
 UNION DISTINCT
 SELECT V010.mandant_id,
  '' AS aktion_id,
  V020.wup_id,
  V020.nb_id,
  V010.art_id,
  V010.kl_art_id,
  'nicht vorhanden' AS aktion_thema_id,
  CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
  CAST(NULL AS INTEGER) AS preisaktiviert_fg,
  CAST(NULL AS INTEGER) AS werbe_kat_id,
  CAST(NULL AS STRING) AS aktionsart_id,
  CAST(NULL AS DATE) AS dat_von,
  CAST(NULL AS DATE) AS dat_bis,
  CAST(NULL AS INTEGER) AS kjwo_ww
 FROM kfl_production_dbp_view.v_art AS V010
  INNER JOIN kfl_production_dbp_view.v_wup AS V020 ON V010.mandant_id = V020.mandant_id AND V020.nb_id = 0 AND V010.dat_bis
      = DATE '9999-12-31' AND V010.mandant_id = 1);

