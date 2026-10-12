DELETE FROM dbp_msi_data.check_blackberry_1
WHERE dat IN (SELECT dat
  FROM dbp_data.tag_1
  WHERE akt_tag = 0);


INSERT INTO dbp_msi_data.check_blackberry_1 (dat, mandant_id, lieferquote_real, lieferquote_def,
 datenquote_real, datenquote_def, bb_fg, check_fg, umsatz_ist, umsatz_vj, umsatz_plan, umsatz_vortag, umsatz_vorwoche,
 kunden_ist, kunden_vj, td_insert, td_update)
(SELECT COALESCE(t05.dat, DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)) AS dat,
  T06.mandant_id,
  COALESCE(t05.flag_lieferung, - 1) AS lieferquote_real,
  T06.lieferquote AS lieferquote_def,
  COALESCE(t05.flag_inhalt, - 1) AS datenquote_real,
  T06.datenquote AS datenquote_def,
   CASE
   WHEN t05.flag_lieferung IS NULL OR COALESCE(t05.flag_lieferung, - 1) > T06.lieferquote AND COALESCE(t05.flag_inhalt,
       - 1) > T06.datenquote
   THEN 1
   ELSE 0
   END AS bb_fg,
   CASE
   WHEN t05.flag_lieferung IS NULL OR COALESCE(t05.flag_lieferung, - 1) > T06.lieferquote AND COALESCE(t05.flag_inhalt,
       - 1) > T06.datenquote
   THEN 1
   ELSE 0
   END AS check_fg,
  COALESCE(t07.umsatz_ist, 0) AS umsatz_ist,
  COALESCE(t07.umsatz_vj, 0) AS umsatz_vj,
  COALESCE(t07.umsatz_plan, 0) AS umsatz_plan,
  COALESCE(t07.umsatz_vortag, 0) AS umsatz_vortag,
  COALESCE(t07.umsatz_vorwoche, 0) AS umsatz_vorwoche,
  COALESCE(t07.kunden_ist, 0) AS kunden_ist,
  COALESCE(t07.kunden_vj, 0) AS kunden_vj,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM (SELECT DISTINCT t01.mandant_id,
    COALESCE(t01.dat, t02.dat, t03.dat) AS dat,
    ROUND(CAST(CAST(IFNULL(t01.count_wup, 0) - IFNULL(t02.count_wup_ber, 0) AS FLOAT64) / t01.count_wup * 100 AS NUMERIC
      ), 2) AS flag_lieferung,
    ROUND(CAST(CAST(IFNULL(t01.count_wup, 0) - IFNULL(t03.count_wup_plausi, 0) AS FLOAT64) / t01.count_wup * 100 AS
      NUMERIC), 2) AS flag_inhalt
   FROM (SELECT T01.dat,
      T01.mandant_id,
      IFNULL(COUNT(T01.wup_id), 0) AS count_wup
     FROM dbp_data.wupcal_1 AS T01
      INNER JOIN dbp_data.tag_1 AS T02 ON T01.dat = T02.dat AND TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T01.dat, INTERVAL 364 DAY)) AS STRING)
            , 1, 19)) || '.' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T01.dat, INTERVAL 364 DAY)) AS STRING), 1,
           19)) = TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T02.dat, INTERVAL 364 DAY)) AS STRING), 1, 19)) || '.' ||
         TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T02.dat, INTERVAL 364 DAY)) AS STRING), 1, 19))
     WHERE T02.akt_tag = 0
      AND T01.offen = 1
      AND T01.nb_id IN (0)
     GROUP BY T01.mandant_id,
      T01.dat) AS t01
    FULL JOIN (SELECT T010.dat,
      T010.mandant_id,
      COUNT(T010.wup_id) AS count_wup_ber
     FROM dbp_data.wupcal_1 AS T010
      INNER JOIN dbp_data.tag_1 AS T020 ON T010.dat = T020.dat AND TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T010.dat, INTERVAL 364 DAY)) AS STRING)
            , 1, 19)) || '.' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T010.dat, INTERVAL 364 DAY)) AS STRING), 1
           , 19)) = TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T020.dat, INTERVAL 364 DAY)) AS STRING), 1, 19)) || '.'
         || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T020.dat, INTERVAL 364 DAY)) AS STRING), 1, 19))
     WHERE T020.akt_tag = 0
      AND T010.offen = 1
      AND T010.nb_id IN (0)
      AND T010.datenlieferung_artbew_wg_sum IN (0, 2)
     GROUP BY T010.mandant_id,
      T010.dat) AS t02 ON t01.dat = t02.dat AND t01.mandant_id = t02.mandant_id
    FULL JOIN (SELECT T011.dat,
      T011.mandant_id,
      COUNT(T011.wup_id) AS count_wup_plausi
     FROM dbp_data.wupcal_1 AS T011
      INNER JOIN dbp_data.tag_1 AS T021 ON T011.dat = T021.dat AND TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T011.dat, INTERVAL 364 DAY)) AS STRING)
            , 1, 19)) || '.' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T011.dat, INTERVAL 364 DAY)) AS STRING), 1
           , 19)) = TRIM(SUBSTR(CAST(EXTRACT(DAY FROM DATE_SUB(T021.dat, INTERVAL 364 DAY)) AS STRING), 1, 19)) || '.'
         || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM DATE_SUB(T021.dat, INTERVAL 364 DAY)) AS STRING), 1, 19))
     WHERE T021.akt_tag = 0
      AND T011.offen = 1
      AND T011.nb_id IN (0)
      AND T011.pruef_status_id_umsatz <= 0
     GROUP BY T011.mandant_id,
      T011.dat) AS t03 ON t01.dat = t03.dat AND t01.mandant_id = t03.mandant_id) AS t05
  FULL JOIN dbp_msi_data.mis_lieferquote_1 AS T06 ON t05.mandant_id = T06.mandant_id
  INNER JOIN (SELECT mandant_id,
    MAX(umsatz_ist) AS umsatz_ist,
    MAX(umsatz_vj) AS umsatz_vj,
    MAX(umsatz_plan) AS umsatz_plan,
    MAX(umsatz_vortag) AS umsatz_vortag,
    MAX(umsatz_vorwoche) AS umsatz_vorwoche,
    MAX(kunden_ist) AS kunden_ist,
    MAX(kunden_vj) AS kunden_vj
   FROM (SELECT T012.mandant_id,
       CASE
       WHEN T022.akt_tag = 0
       THEN SUM(T012.ums_netto)
       ELSE NULL
       END AS umsatz_ist,
       CASE
       WHEN T022.akt_tag = 0
       THEN SUM(T012.ums_netto_wvj)
       ELSE NULL
       END AS umsatz_vj,
       CASE
       WHEN T022.akt_tag = 0
       THEN SUM(T012.ums_netto_plan)
       ELSE NULL
       END AS umsatz_plan,
       CASE
       WHEN T022.akt_tag = - 1
       THEN SUM(T012.ums_netto)
       ELSE NULL
       END AS umsatz_vortag,
       CASE
       WHEN T022.akt_tag = - 7
       THEN SUM(T012.ums_netto)
       ELSE NULL
       END AS umsatz_vorwoche,
       CASE
       WHEN T022.akt_tag = 0
       THEN SUM(T012.anz_kunde)
       ELSE NULL
       END AS kunden_ist,
       CASE
       WHEN T022.akt_tag = 0
       THEN SUM(T012.anz_kunde_wvj)
       ELSE NULL
       END AS kunden_vj
     FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS T012
      INNER JOIN dbp_data.tag_1 AS T022 ON T012.dat = T022.dat
     WHERE T022.akt_tag IN (0, - 1, - 7)
      AND T012.nb_id = 0
      AND T012.wrg_id = 'EUR'
     GROUP BY T012.mandant_id,
      T022.akt_tag) AS t01
   GROUP BY mandant_id) AS t07 ON T06.mandant_id = t07.mandant_id);