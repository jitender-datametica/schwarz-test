DROP TABLE IF EXISTS dbp_etl.mk_tmp0_art_vorauswahl_6wo;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_tmp0_art_vorauswahl_6wo(
  analyse_dat DATE,
  mandant_id INTEGER,
  wup_id INTEGER,
  art_id INTEGER,
  abt_id INTEGER,
  min_dat DATE,
  max_dat DATE,
  wtag_id INTEGER,
  sum_menge NUMERIC(29, 4),
  sum_umsatz_brutto NUMERIC(29, 4));

INSERT INTO dbp_etl.mk_tmp0_art_vorauswahl_6wo
  (
    analyse_dat,
    mandant_id,
    wup_id,
    art_id,
    abt_id,
    MIN_dat,
    max_dat,
    wtag_id,
    sum_menge,
    sum_umsatz_brutto)
SELECT
  CURRENT_DATE("Europe/Berlin")() AS analyse_dat,
  t01.mandant_id,
  t01.wup_id,
  t10.art_id,
  t04.abt_id,
  MIN(ttag.dat),
  MAX(ttag.dat),
  ttag.wtag_id,
  CAST(COUNT(DISTINCT t01.bon_id) AS NUMERIC) AS sum_menge,
  SUM(t01.umsatz_brutto) AS sum_umsatz_brutto
FROM
  dbp_ods.ods_bon_kopf AS t02
INNER JOIN dbp_ods.ods_bon_verkauf AS t01
  ON
    t02.mandant_id = t01.mandant_id
    AND t02.bon_id = t01.bon_id
    AND t01.aktion_id = ''
    AND t02.mandant_id = 1
INNER JOIN
  (
    SELECT
      ttag_0.dat,
      ttag_0.wtag_id
    FROM
      dbp_data.tag AS ttag_0
    WHERE
      ttag_0.dat
      BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin")(), INTERVAL ${days} DAY)
      AND CURRENT_DATE("Europe/Berlin")()
  ) AS ttag
  ON t02.bon_dat = ttag.dat
-- üblicher join, um kl_art_id und art_id zu verbinden
INNER JOIN
  (
    SELECT
      art.kl_art_id,
      art.mandant_id,
      MAX(art.art_id) AS art_id
    FROM
      dbp_data.art
    WHERE
      art.display_id = 0
      AND art.loesch_id = ''
      AND art.posten_id = ''
      AND art.wg_art_fg = 0
      AND art_id > 0
    GROUP BY 1, 2
  ) AS t10
  ON
    t01.mandant_id = t10.mandant_id
    AND t01.kl_art_id = t10.kl_art_id
INNER JOIN dbp_data.art_wg_zu_per AS t03
  ON
    t10.mandant_id = t03.mandant_id
    AND t10.art_id = t03.art_id
    -- aktuell gueltige einträge der art_wg_zu_per
    AND t03.dat_bis = PARSE_DATE('%y-%m-%d', '9999-12-31')
    AND t03.arthiertyp_id = 2  /* 3stellige wg*/
INNER JOIN dbp_data.wg_per AS t04
  ON
    t03.mandant_id = t04.mandant_id
    AND t03.wg_id = t04.wg_id
    AND t03.arthiertyp_id = t04.arthiertyp_id
    -- aktuell gueltige einträge der wg_per
    AND t04.dat_bis = PARSE_DATE('%y-%m-%d', '9999-12-31')
-- kdis kennzeichen auf 0 steht
INNER JOIN dbp_data.art_wup_status_per AS t05
  ON
    t01.mandant_id = t05.mandant_id
    AND t01.wup_id = t05.wup_id
    AND t10.art_id = t05.art_id
    AND t05.dispomerkmal IN ('01', '11', 'zz')
    AND t05.kdis = 0
    AND t05.dat_bis = PARSE_DATE('%y-%m-%d', '9999-12-31')
INNER JOIN dbp_data.wg_filter_zu AS f_food
  ON
    t04.mandant_id = f_food.mandant_id
    AND t04.wg_id = f_food.wg_id
    AND f_food.arthiertyp_id = 2
    AND f_food.wg_filter_id = 8
INNER JOIN dbp_msi_data.l_mk_wup AS f_mk
  ON
    t01.mandant_id = f_mk.mandant_id
    AND t01.wup_id = f_mk.wup_id
LEFT JOIN dbp_data.wg_filter_zu AS f_exclude
  ON
    t03.mandant_id = f_exclude.mandant_id
    AND t03.wg_id = f_exclude.wg_id
    AND f_exclude.arthiertyp_id = 2
    AND f_exclude.wg_filter_id = 7
WHERE f_exclude.wg_id IS NULL
GROUP BY 2, 3, 4, 5, 8;

DROP TABLE IF EXISTS dbp_etl.mk_wupcal;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_wupcal(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  dat DATE,
  wtag_id INTEGER,
  offen INTEGER);

INSERT INTO dbp_etl.mk_wupcal
  (mandant_id, wup_id, nb_id, dat, wtag_id, offen)
    (
      SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.dat,
        T02.wtag_id,
        T01.offen
      FROM dbp_data.wupcal AS T01
      INNER JOIN dbp_data.tag AS T02
        ON
          T01.dat = T02.dat
          AND T01.mandant_id = 1
          AND T01.nb_id = 0
          AND T02.wtag_id
            <> 7
    );

DROP TABLE IF EXISTS dbp_etl.mk_tmp1_art_vorauswahl_6wo;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_tmp1_art_vorauswahl_6wo(
  mandant_id INTEGER,
  wup_id INTEGER,
  art_id INTEGER,
  abt_id INTEGER,
  min_dat DATE,
  max_dat DATE,
  wtag_id INTEGER,
  cnt_tag_reg INTEGER,
  sum_menge NUMERIC(29, 4),
  sum_umsatz_brutto NUMERIC(29, 4),
  avg_menge NUMERIC(29, 4),
  avg_umsatz_brutto NUMERIC(29, 4),
  rank_menge INTEGER,
  rank_umsatz_brutto INTEGER);

-- Anzahl der Aktionstage des Artikels
-- Anzahl der offenen Tage nach der letzten Aktivierung
INSERT INTO dbp_etl.mk_tmp1_art_vorauswahl_6wo
  (
    mandant_id,
    wup_id,
    art_id,
    abt_id,
    min_dat,
    max_dat,
    wtag_id,
    cnt_tag_reg,
    sum_menge,
    sum_umsatz_brutto,
    avg_menge,
    avg_umsatz_brutto,
    rank_menge,
    rank_umsatz_brutto)
    (
      SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.art_id,
        T01.abt_id,
        T01.min_dat,
        T01.max_dat,
        T01.wtag_id,
        IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) AS cnt_dat_reg,
        T01.sum_menge,
        T01.sum_umsatz_brutto,
        T01.sum_menge
          / IF(
            IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) = 0,
            NULL,
            IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0)) AS avg_menge,
        T01.sum_umsatz_brutto
          / IF(
            IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) = 0,
            NULL,
            IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0))
          AS avg_umsatz_brutto,
        RANK()
          OVER (
            PARTITION BY T01.wtag_id
            ORDER BY(
              T01.sum_menge
                  / IF(
                    IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) = 0,
                    NULL,
                    IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0)))
                IS NULL DESC,
            T01.sum_menge
              / IF(
                IFNULL(t2.cnt_dat, 0)
                    - IFNULL(t08.cnt_dat, 0)
                  = 0,
                NULL,
                IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0)) DESC
          ) AS rank_menge,
        RANK()
          OVER (
            PARTITION BY T01.wtag_id
            ORDER BY(
              T01.sum_umsatz_brutto
                  / IF(
                    IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) = 0,
                    NULL,
                    IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0)))
                IS NULL DESC,
            T01.sum_umsatz_brutto
              / IF(
                IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0) = 0,
                NULL,
                IFNULL(t2.cnt_dat, 0) - IFNULL(t08.cnt_dat, 0)) DESC
          ) AS rank_umsatz_brutto
      FROM dbp_etl.mk_tmp0_art_vorauswahl_6wo AS T01
      INNER JOIN
        (
          SELECT
            T02.mandant_id,
            T02.wup_id,
            t01.min_dat,
            t01.wtag_id,
            COUNT(DISTINCT T02.dat) AS cnt_dat
          FROM dbp_etl.mk_wupcal AS T02
          INNER JOIN
            (
              SELECT
                t10.mandant_id,
                t10.wup_id,
                t10.min_dat,
                t10.max_dat,
                TTAG.dat,
                TTAG.wtag_id
              FROM
                (
                  SELECT
                    mandant_id,
                    wup_id,
                    MIN(min_dat) AS min_dat,
                    MAX(max_dat) AS max_dat
                  FROM dbp_etl.mk_tmp0_art_vorauswahl_6wo
                  GROUP BY
                    mandant_id,
                    wup_id
                ) AS t10
              INNER JOIN dbp_data.tag AS TTAG
                ON TTAG.dat BETWEEN t10.min_dat AND t10.max_dat
            ) AS t01
            ON
              T02.mandant_id
                = t01.mandant_id
              AND T02.wup_id = t01.wup_id
              AND T02.dat BETWEEN t01.min_dat AND t01.max_dat
              AND T02.wtag_id = t01.wtag_id
              AND T02.offen = 1
          GROUP BY
            T02.mandant_id,
            T02.wup_id,
            t01.min_dat,
            t01.wtag_id
        ) AS t2
        ON
          T01.mandant_id = t2.mandant_id
          AND T01.wup_id = t2.wup_id
          AND T01.wtag_id = t2.wtag_id
      LEFT JOIN
        (
          SELECT
            t04.mandant_id,
            t04.wup_id,
            t04.art_id,
            t04.wtag_id,
            COUNT(DISTINCT T07.dat) AS cnt_dat
          FROM
            (
              SELECT
                t10.mandant_id,
                t10.wup_id,
                t10.art_id,
                t10.min_dat,
                t10.max_dat,
                TTAG0.dat,
                TTAG0.wtag_id
              FROM
                (
                  SELECT
                    mandant_id,
                    wup_id,
                    art_id,
                    min_dat,
                    max_dat
                  FROM dbp_etl.mk_tmp0_art_vorauswahl_6wo
                ) AS t10
              INNER JOIN dbp_data.tag AS TTAG0
                ON TTAG0.dat BETWEEN t10.min_dat AND t10.max_dat
            ) AS t04
          INNER JOIN dbp_data.aktion_art_wup_zu AS T05
            ON
              t04.mandant_id = T05.mandant_id
              AND t04.wup_id = T05.wup_id
              AND t04.art_id = T05.art_id
          INNER JOIN dbp_data.aktion AS T06
            ON
              T05.mandant_id = T06.mandant_id
              AND T05.aktion_id = T06.aktion_id
              AND T06.preisaktiviert_fg = 1
              /* AND       t06.dat_von <=  t04.min_dat
AND       t06.dat_bis >=  t04.max_dat
Änderung der Bedingung, um auch Teilweise Überschneidungen zu erfassen */
              AND t04.max_dat >= T06.dat_von
              AND t04.min_dat < T06.dat_bis
          INNER JOIN dbp_etl.mk_wupcal AS T07
            ON
              t04.mandant_id = T07.mandant_id
              AND t04.wup_id = T07.wup_id
              AND T07.dat BETWEEN T06.dat_von AND T06.dat_bis
              AND T07.dat BETWEEN t04.min_dat AND t04.max_dat
              AND t04.wtag_id
                = T07.wtag_id
              AND T07.offen = 1
          GROUP BY
            t04.mandant_id,
            t04.wup_id,
            t04.art_id,
            t04.wtag_id
        ) AS t08
        ON
          T01.mandant_id = t08.mandant_id
          AND T01.wup_id = t08.wup_id
          AND T01.art_id = t08.art_id
          AND T01.wtag_id = t08.wtag_id
          AND t2.cnt_dat <> t08.cnt_dat
    );

DROP TABLE IF EXISTS dbp_etl.mk_tmp_art_wug_prom;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_tmp_art_wug_prom(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  art_id INTEGER,
  wg_id INTEGER,
  wug_id INTEGER,
  abt_id INTEGER,
  dat DATE,
  wtag_id INTEGER,
  gewart_id STRING(3) COLLATE 'und:ci',
  menge NUMERIC(29, 4));

-- Begrenzung auf die Märkte der Vorauswahl

-- Nur Abteilung Food wird berücksichtigt - geändert, vorher nur 4, in Tabelle aufgenommen

-- 24.02.14 TBac: In der artbew sind pro Artikel-Tag-Markt mehrere Datensaetze vorhanden (EAN mit im Schluessel). Daher Summierung der Menge!)

-- Nur die nicht über Warengruppen erfassten Artikel
INSERT INTO dbp_etl.mk_tmp_art_wug_prom
  (
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    wg_id,
    wug_id,
    abt_id,
    dat,
    wtag_id,
    gewart_id,
    menge)
    (
      SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.art_id,
        T03.wg_id,
        T03.wug_id,
        T04.abt_id,
        T01.dat,
        T06.wtag_id,
        T02.gewart_id,
        SUM(T01.menge) AS menge
      FROM dbp_data.artbew AS T01
      INNER JOIN dbp_msi_data.l_mk_wup AS A
        ON
          T01.wup_id = A.wup_id
          AND T01.mandant_id = A.mandant_id
          AND T01.mandant_id = 1
      INNER JOIN dbp_data.art AS T02
        ON
          T01.mandant_id = T02.mandant_id
          AND T01.art_id = T02.art_id
          -- Ausschluss von Nicht-Promotionverkäufen
          AND T01.bewart_id = 1002  -- sonderaktion

          -- Einschränkung des Betrachtungszeitraums - die letzten vollen 12 Monate
          AND T01.dat
            BETWEEN DATE_SUB(
              IF(
                DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
                  = LAST_DAY(
                    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)),
                LAST_DAY(
                  DATE_ADD(
                    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY),
                    INTERVAL -12 MONTH)),
                DATE_ADD(
                  DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY),
                  INTERVAL
                    -12
                      MONTH)),
              INTERVAL
                EXTRACT(
                  DAY
                  FROM DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
                - 1 DAY)
            AND (
              DATE_SUB(
                DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY),
                INTERVAL
                  EXTRACT(
                    DAY
                    FROM
                      DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
                    DAY))
          AND T02.wg_art_fg
            = 0
          AND T02.art_id > 0  -- Ausschluss von Postenartikeln
          AND T02.posten_id = ''
          -- Ausschluss von gelöschten Artikeln
          AND T02.loesch_id = ''  -- Ausschluss Display
          AND T02.display_id = 0
      INNER JOIN dbp_data.tag AS T06
        ON T01.dat = T06.dat
      INNER JOIN dbp_data.art_wg_zu_per AS T03
        ON
          T02.mandant_id = T03.mandant_id
          AND T02.art_id = T03.art_id
          -- Aktuell gueltige Einträge der art_wg_zu_per
          AND T03.dat_bis = PARSE_DATE('%F', '9999-12-31')
          AND T03.arthiertyp_id
            = 2
      INNER JOIN dbp_data.wg_per AS T04
        ON
          T03.mandant_id = T04.mandant_id
          AND T03.wg_id = T04.wg_id
          AND T03.arthiertyp_id
            = T04.arthiertyp_id  -- Aktuell gueltige Einträge der wg_per
          AND T04.dat_bis = PARSE_DATE(
            '%F',
            '9999-12-31')
      INNER JOIN
        (
          SELECT
            mandant_id,
            wup_id,
            art_id
          FROM dbp_data.art_wup_status_per
          WHERE
            dispomerkmal IN ('01', '11', 'ZZ')
            AND kdis = 0
            AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        ) AS t05
        ON
          T01.mandant_id = t05.mandant_id
          AND T01.wup_id = t05.wup_id
          AND T02.art_id
            = t05.art_id  -- Ausschluss bestimmter Warengruppen aus der Abteilung Food
      WHERE
        (T04.mandant_id, T04.wg_id)
          IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu
            WHERE
              arthiertyp_id = 2
              AND wg_filter_id = 8
          )
        AND (T03.mandant_id, T03.wg_id)
          NOT IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu
            WHERE
              arthiertyp_id = 2
              AND wg_filter_id = 7
          )
      GROUP BY
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.dat,
        T01.art_id,
        T02.gewart_id,
        T06.wtag_id,
        T03.wg_id,
        T03.wug_id,
        T04.abt_id
    );

DELETE FROM dbp_data.mk_art_wup_auswahl
WHERE
  dat_von = CURRENT_DATE("Europe/Berlin")
  AND (wup_id, mandant_id)
    IN (SELECT (wup_id, mandant_id) FROM dbp_msi_data.l_mk_wup);

DROP TABLE IF EXISTS dbp_etl.mk_tmp_art_wup_auswahl;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_tmp_art_wup_auswahl(
  mandant_id INTEGER,
  wup_id INTEGER,
  wtag_id INTEGER,
  nb_id INTEGER,
  art_id INTEGER,
  avg_menge NUMERIC(29, 3),
  anz_tage_in_aktion INTEGER,
  aktion_fg INTEGER,
  aktiv_fg INTEGER,
  anz_tage_0verkauf INTEGER,
  dat_von DATE,
  dat_bis DATE);

-- Artikel aus der Tabelle mit den regulären Verkäufen - 6 Wochen
INSERT INTO dbp_etl.mk_tmp_art_wup_auswahl
  (
    mandant_id,
    wup_id,
    wtag_id,
    nb_id,
    art_id,
    avg_menge,
    anz_tage_in_aktion,
    aktion_fg,
    aktiv_fg,
    anz_tage_0verkauf,
    dat_von,
    dat_bis)
    (
      SELECT
        mandant_id,
        wup_id,
        wtag_id,
        nb_id,
        art_id,
        avg_menge,
        anz_tage_in_aktion,
        aktion_fg,
        1 AS aktiv_fg,
        0 AS anz_tage_0verkauf,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis
      FROM
        (
          SELECT
            T01.mandant_id,
            T01.wup_id,
            T02.nb_id,
            T01.wtag_id,
            T01.art_id,
            T01.avg_menge,
            6 - T01.cnt_tag_reg AS anz_tage_in_aktion,
            0 AS aktion_fg
          FROM dbp_etl.mk_tmp1_art_vorauswahl_6wo AS T01
          INNER JOIN dbp_data.wup AS T02
            ON T01.wup_id = T02.wup_id AND T01.mandant_id = T02.mandant_id
          WHERE T01.avg_menge >= 7
          UNION DISTINCT
          SELECT
            1 AS mandant_id,
            T1.wup_id,
            T1.nb_id,
            T1.wtag_id,
            T1.art_id,
            SUM(T1.menge) / t2.cnt_dat AS avg_menge,
            t2.cnt_dat AS anz_tage_in_aktion,
            1 AS aktion_fg
          FROM dbp_etl.mk_tmp_art_wug_prom AS T1
          INNER JOIN
            (
              SELECT
                wup_id,
                art_id,
                MAX(cnt_dat) AS cnt_dat
              FROM
                (
                  SELECT
                    wup_id,
                    art_id,
                    wtag_id,
                    COUNT(*) AS cnt_dat
                  FROM dbp_etl.mk_tmp_art_wug_prom
                  GROUP BY
                    wup_id,
                    art_id,
                    wtag_id
                ) AS tt2
              GROUP BY
                wup_id,
                art_id
            ) AS t2
            ON T1.wup_id = t2.wup_id AND T1.art_id = t2.art_id
          GROUP BY
            mandant_id,
            T1.wup_id,
            T1.nb_id,
            T1.wtag_id,
            T1.art_id,
            anz_tage_in_aktion,
            t2.cnt_dat
          HAVING SUM(T1.menge) / t2.cnt_dat >= 7
          -- tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
          -- WHERE t2.cnt_dat <= 99
        ) AS t03
    );

UPDATE dbp_data.mk_art_wup_auswahl
SET
  dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');

INSERT INTO dbp_data.mk_art_wup_auswahl
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    aktiv_fg,
    anz_tage_0verkauf,
    anz_tage_in_aktion)
    (
      SELECT
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        avg_menge,
        aktiv_fg,
        anz_tage_0verkauf,
        anz_tage_in_aktion
      FROM dbp_etl.mk_tmp_art_wup_auswahl AS T01
    );

DROP TABLE IF EXISTS dbp_etl.mk_tmp_wup_art_std_wt;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_tmp_wup_art_std_wt(
  mandant_id INTEGER,
  wup_id INTEGER,
  art_id INTEGER,
  bon_dat DATE,
  bon_std INTEGER,
  anz INTEGER,
  menge INTEGER,
  offen INTEGER);

-- Nur KDIS Kennzeichen 0 u. dispomerkmal 01,11,ZZ

-- Nur Abteilung Food wird berücksichtigt - geändert, vorher nur 4, in Tabelle aufgenommen
INSERT INTO dbp_etl.mk_tmp_wup_art_std_wt
  (mandant_id, wup_id, art_id, bon_dat, bon_std, anz, menge, offen)
    (
      SELECT
        T02.mandant_id,
        T02.wup_id,
        t1.art_id,
        T02.bon_dat,
        EXTRACT(HOUR FROM T02.bon_booking) AS bon_std,
        COUNT(DISTINCT T03.bon_id) AS anz,
        CAST(SUM(T03.menge) AS INTEGER) AS menge,
        T04.offen
      FROM dbp_ods.ods_bon_kopf AS T02
      INNER JOIN dbp_ods.ods_bon_verkauf AS T03
        ON T02.mandant_id = T03.mandant_id AND T02.bon_id = T03.bon_id
      INNER JOIN dbp_etl.mk_wupcal AS T04
        ON
          T02.mandant_id = T04.mandant_id
          AND T02.wup_id = T04.wup_id
          AND T02.bon_dat = T04.dat
      INNER JOIN
        (
          SELECT
            kl_art_id,
            mandant_id,
            MAX(art_id) AS art_id
          FROM dbp_data.art
          WHERE
            display_id = 0
            AND loesch_id = ''
            AND posten_id = ''
            AND wg_art_fg = 0
            AND art_id > 0
          GROUP BY
            mandant_id,
            kl_art_id
        ) AS t1
        ON T03.kl_art_id = t1.kl_art_id AND T03.mandant_id = t1.mandant_id
      INNER JOIN dbp_data.art_wg_zu_per AS T05
        ON
          t1.mandant_id = T05.mandant_id
          AND t1.art_id = T05.art_id
          -- Aktuell gueltige Einträge der art_wg_zu_per
          AND T05.dat_bis = PARSE_DATE('%F', '9999-12-31')
          AND T05.arthiertyp_id
            = 2  -- 3stellige WG
      INNER JOIN dbp_data.wg_per AS T06
        ON
          T05.mandant_id = T06.mandant_id
          AND T05.wg_id = T06.wg_id
          AND T05.arthiertyp_id
            = T06.arthiertyp_id  -- Aktuell gueltige Einträge der wg_per
          AND T06.dat_bis = PARSE_DATE(
            '%F',
            '9999-12-31')
      INNER JOIN
        (
          SELECT
            mandant_id,
            wup_id,
            art_id
          FROM dbp_data.art_wup_status_per
          WHERE
            dispomerkmal IN ('01', '11', 'ZZ')
            AND kdis = 0
            AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        ) AS t07
        ON
          T02.mandant_id = t07.mandant_id
          AND T02.wup_id = t07.wup_id
          AND t1.art_id = t07.art_id
      WHERE
        T02.mandant_id = 1
        AND (T02.mandant_id, T02.wup_id)
          IN (SELECT (mandant_id, wup_id) FROM dbp_msi_data.l_mk_wup)
        AND T02.bon_dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY)
          AND (
            CURRENT_DATE("Europe/Berlin")
            -- Ausschluss bestimmter Warengruppen aus der Abteilung Food
          )
        AND (T06.mandant_id, T06.wg_id)
          IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu
            WHERE
              arthiertyp_id = 2
              AND wg_filter_id = 8
          )
        AND (T05.mandant_id, T05.wg_id)
          NOT IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu
            WHERE
              arthiertyp_id = 2
              AND wg_filter_id = 7
          )
      GROUP BY
        T02.mandant_id,
        T02.wup_id,
        t1.art_id,
        T02.bon_dat,
        bon_std,
        T04.offen
    );

DROP TABLE IF EXISTS dbp_etl.mk_promocal;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_promocal(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  art_id INTEGER,
  dat DATE);

INSERT INTO dbp_etl.mk_promocal
  (mandant_id, wup_id, nb_id, art_id, dat)
    (
      SELECT
        t05.mandant_id,
        t05.wup_id,
        t05.nb_id,
        t05.art_id,
        t05.dat
      FROM
        (
          SELECT
            T01.mandant_id,
            T01.wup_id,
            T01.nb_id,
            T01.art_id,
            T04.dat,
            T02.vk_aktion_brutto
          FROM dbp_etl.mk_tmp_art_wup_auswahl AS T01
          INNER JOIN dbp_data.aktion_art_wup_zu AS T02
            ON
              T01.mandant_id = T02.mandant_id
              AND T01.wup_id = T02.wup_id
              AND T01.nb_id = T02.nb_id
              AND T01.art_id = T02.art_id
          INNER JOIN dbp_data.aktion AS T03
            ON
              T02.mandant_id = T03.mandant_id
              AND T02.aktion_id = T03.aktion_id
              AND T03.preisaktiviert_fg = 1
          INNER JOIN dbp_data.tag AS T04
            ON T04.dat BETWEEN T03.dat_von AND T03.dat_bis
          WHERE
            T01.aktion_fg = 1
            AND T01.aktiv_fg = 1
            AND CURRENT_DATE("Europe/Berlin")
              BETWEEN T01.dat_von
              AND T01.dat_bis
            AND T02.grund_sperrung IS NULL
            AND T04.dat
              BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY)
              AND (CURRENT_DATE("Europe/Berlin"))
          QUALIFY
            (
              RANK()
                OVER (
                  PARTITION BY T01.mandant_id, T01.wup_id, T01.art_id, T04.dat
                  ORDER BY T02.aktion_id IS NULL DESC, T02.aktion_id DESC
                ))
            = 1
        ) AS t05
      INNER JOIN dbp_data.art_wup_zu_per AS T06
        ON
          t05.mandant_id = T06.mandant_id
          AND t05.wup_id = T06.wup_id
          AND t05.art_id = T06.art_id
          AND t05.dat BETWEEN T06.dat_von AND T06.dat_bis
      GROUP BY
        t05.mandant_id,
        t05.wup_id,
        t05.nb_id,
        t05.art_id,
        t05.dat
    );

DROP TABLE IF EXISTS dbp_etl.mk_wupartcal;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_wupartcal(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  art_id INTEGER,
  dat DATE,
  wtag_id INTEGER,
  aktion_fg INTEGER,
  saison_fg STRING(1) COLLATE 'und:ci');

-- Setzen des Saison Flags (Winter: NOV-MRZ, Sommer: APR-OKT)
INSERT INTO dbp_etl.mk_wupartcal
  (mandant_id, wup_id, nb_id, art_id, dat, wtag_id, aktion_fg, saison_fg)
    (
      SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        wtag_id,
        this_aktion_fg AS aktion_fg,
        saison_fg
      FROM
        (
          SELECT
            T01.mandant_id,
            T01.wup_id,
            T01.nb_id,
            T02.art_id,
            T01.dat,
            T01.wtag_id  -- , t02.reg_fg
              ,
            T02.aktion_fg  -- Überprüfung ob Promotion (1), regulärer (0)
              ,
            CASE
              WHEN T03.art_id IS NOT NULL
                THEN 1
              ELSE 0
              END AS this_aktion_fg,
            CASE
              WHEN EXTRACT(MONTH FROM T01.dat) BETWEEN 4 AND 10
                THEN 'S'
              ELSE 'W'
              END AS saison_fg,
            T01.offen
          FROM dbp_etl.mk_wupcal AS T01
          INNER JOIN dbp_etl.mk_tmp_art_wup_auswahl AS T02
            ON
              T01.mandant_id = T02.mandant_id
              AND T01.wup_id = T02.wup_id
              AND T01.dat
                BETWEEN DATE_SUB(
                  CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY)
                AND (CURRENT_DATE("Europe/Berlin"))
              AND T02.aktiv_fg = 1
              AND CURRENT_DATE("Europe/Berlin")
                BETWEEN T02.dat_von
                AND T02.dat_bis
          LEFT JOIN dbp_etl.mk_promocal AS T03
            ON
              T01.mandant_id = T03.mandant_id
              AND T01.wup_id = T03.wup_id
              AND T01.nb_id = T03.nb_id
              AND T02.art_id = T03.art_id
              AND T01.dat = T03.dat
          INNER JOIN dbp_data.art_wup_zu_per AS T04
            ON
              T01.mandant_id = T04.mandant_id
              AND T01.wup_id = T04.wup_id
              AND T01.nb_id = T04.nb_id
              AND T02.art_id = T04.art_id
              AND T01.dat BETWEEN T04.dat_von AND T04.dat_bis
        ) AS t05
      WHERE
        dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY)
          AND (CURRENT_DATE("Europe/Berlin"))
        AND offen = 1
        AND (
          this_aktion_fg = 1 AND aktion_fg = 1
          OR this_aktion_fg IN (0) AND aktion_fg = 0)
      GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        wtag_id,
        aktion_fg,
        saison_fg
    );

DROP TABLE IF EXISTS dbp_etl.mk_bonverteilung_wt_zf;

CREATE TABLE IF NOT EXISTS dbp_etl.mk_bonverteilung_wt_zf
AS
SELECT
  T01.mandant_id,
  T01.wup_id,
  T01.nb_id,
  T01.art_id,
  T07.art_bez,
  T01.aktion_fg,
  T06.wtag_id,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 1
          THEN COALESCE(T05.anz, 0)
        ELSE NULL
        END),
    0) AS anz_zf1,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 2
          THEN COALESCE(T05.anz, 0)
        ELSE NULL
        END),
    0) AS anz_zf2,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 3
          THEN COALESCE(T05.anz, 0)
        ELSE NULL
        END),
    0) AS anz_zf3,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 1
          THEN COALESCE(T05.menge, 0)
        ELSE NULL
        END),
    0) AS menge_zf1,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 2
          THEN COALESCE(T05.menge, 0)
        ELSE NULL
        END),
    0) AS menge_zf2,
  COALESCE(
    SUM(
      CASE
        WHEN ZF.zeitfenster_id = 3
          THEN COALESCE(T05.menge, 0)
        ELSE NULL
        END),
    0) AS menge_zf3,
  COUNT(DISTINCT T05.bon_dat) AS anz_tage
FROM dbp_etl.mk_wupartcal AS T01
LEFT JOIN dbp_etl.mk_tmp_wup_art_std_wt AS T05
  ON
    T01.mandant_id = T05.mandant_id
    AND T01.wup_id = T05.wup_id
    AND T01.art_id = T05.art_id
    AND T01.dat = T05.bon_dat
INNER JOIN dbp_data.tag AS T06
  ON T05.bon_dat = T06.dat
INNER JOIN dbp_data.art_spr_zu AS T07
  ON
    T01.mandant_id = T07.mandant_id
    AND T01.art_id = T07.art_id
    AND T07.spr_id = 22
INNER JOIN dbp_data.l_zeitfenster AS ZF
  ON
    T01.mandant_id = ZF.mandant_id
    AND T05.bon_std >= EXTRACT(HOUR FROM ZF.zeit_von)
    AND T05.bon_std < EXTRACT(HOUR FROM ZF.zeit_bis)
WHERE
  T05.offen = 1
  AND T01.dat >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${days} DAY)
  AND T01.aktion_fg = 0
GROUP BY
  T01.mandant_id,
  T01.wup_id,
  T01.nb_id,
  T01.art_id,
  T07.art_bez,
  T01.aktion_fg,
  T06.wtag_id
HAVING anz_tage >= 4;

DROP TABLE IF EXISTS dbp_etl.tmp_mk_art_wup_zeitfenster;

CREATE TABLE IF NOT EXISTS dbp_etl.tmp_mk_art_wup_zeitfenster(
  wup_id INTEGER NOT NULL,
  nb_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  art_id INTEGER NOT NULL,
  wtag_id INTEGER NOT NULL,
  zeitfenster_id INTEGER NOT NULL,
  aktion_fg INTEGER,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  avg_menge NUMERIC(29, 3),
  anz_tage_in_aktion INTEGER);

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        1 AS zeitfenster_id,
        aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        anz_zf1 / CAST(anz_tage AS NUMERIC) AS avg_anzahl,
        anz_tage
      FROM dbp_etl.mk_bonverteilung_wt_zf AS T01
      WHERE anz_zf1 / CAST(anz_tage AS NUMERIC) >= 7
    );

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        2 AS zeitfenster_id,
        aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        anz_zf2 / CAST(anz_tage AS NUMERIC) AS avg_anzahl,
        anz_tage
      FROM dbp_etl.mk_bonverteilung_wt_zf AS T01
      WHERE anz_zf2 / CAST(anz_tage AS NUMERIC) >= 7
    );

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        3 AS zeitfenster_id,
        aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        anz_zf3 / CAST(anz_tage AS NUMERIC) AS avg_anzahl,
        anz_tage
      FROM dbp_etl.mk_bonverteilung_wt_zf AS T01
      WHERE anz_zf3 / CAST(anz_tage AS NUMERIC) >= 7
    );

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        t0.wup_id,
        t0.nb_id,
        t0.mandant_id,
        t0.art_id,
        t0.wtag_id,
        1 AS zeitfenster_id,
        1 AS aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) AS avg_menge,
        COALESCE(t2.cnt_dat, 0) AS cnt_dat
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            art_id,
            wtag_id,
            nb_id,
            SUM(menge) AS menge
          FROM dbp_etl.mk_tmp_art_wug_prom
          GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            art_id,
            wtag_id
        ) AS t0
      LEFT JOIN
        (
          SELECT
            wup_id,
            art_id,
            MAX(cnt_dat) AS cnt_dat
          FROM
            (
              SELECT
                wup_id,
                art_id,
                wtag_id,
                COUNT(*) AS cnt_dat
              FROM dbp_etl.mk_tmp_art_wug_prom
              GROUP BY
                wup_id,
                art_id,
                wtag_id
            ) AS tt2
          GROUP BY
            wup_id,
            art_id
        ) AS t2
        ON t0.wup_id = t2.wup_id AND t0.art_id = t2.art_id
      WHERE t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) >= 10
      -- tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
      -- AND t2.cnt_dat <= 99
    );

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        t0.wup_id,
        t0.nb_id,
        t0.mandant_id,
        t0.art_id,
        t0.wtag_id,
        2 AS zeitfenster_id,
        1 AS aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) AS avg_menge,
        COALESCE(t2.cnt_dat, 0) AS cnt_dat
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            art_id,
            wtag_id,
            nb_id,
            SUM(menge) AS menge
          FROM dbp_etl.mk_tmp_art_wug_prom
          GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            art_id,
            wtag_id
        ) AS t0
      LEFT JOIN
        (
          SELECT
            wup_id,
            art_id,
            MAX(cnt_dat) AS cnt_dat
          FROM
            (
              SELECT
                wup_id,
                art_id,
                wtag_id,
                COUNT(*) AS cnt_dat
              FROM dbp_etl.mk_tmp_art_wug_prom
              GROUP BY
                wup_id,
                art_id,
                wtag_id
            ) AS tt2
          GROUP BY
            wup_id,
            art_id
        ) AS t2
        ON t0.wup_id = t2.wup_id AND t0.art_id = t2.art_id
      WHERE t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) >= 10
      -- tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
      -- AND t2.cnt_dat <= 99
    );

INSERT INTO dbp_etl.tmp_mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        t0.wup_id,
        t0.nb_id,
        t0.mandant_id,
        t0.art_id,
        t0.wtag_id,
        3 AS zeitfenster_id,
        1 AS aktion_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) AS avg_menge,
        COALESCE(t2.cnt_dat, 0) AS cnt_dat
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            art_id,
            wtag_id,
            nb_id,
            SUM(menge) AS menge
          FROM dbp_etl.mk_tmp_art_wug_prom
          GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            art_id,
            wtag_id
        ) AS t0
      LEFT JOIN
        (
          SELECT
            wup_id,
            art_id,
            MAX(cnt_dat) AS cnt_dat
          FROM
            (
              SELECT
                wup_id,
                art_id,
                wtag_id,
                COUNT(*) AS cnt_dat
              FROM dbp_etl.mk_tmp_art_wug_prom
              GROUP BY
                wup_id,
                art_id,
                wtag_id
            ) AS tt2
          GROUP BY
            wup_id,
            art_id
        ) AS t2
        ON t0.wup_id = t2.wup_id AND t0.art_id = t2.art_id
      WHERE t0.menge / IF(t2.cnt_dat = 0, NULL, t2.cnt_dat) >= 35
      -- tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
      -- AND t2.cnt_dat <= 99
    );

DELETE FROM dbp_data.mk_art_wup_zeitfenster
WHERE dat_von = CURRENT_DATE("Europe/Berlin");

UPDATE dbp_data.mk_art_wup_zeitfenster
SET
  dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');

INSERT INTO dbp_data.mk_art_wup_zeitfenster
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    wtag_id,
    zeitfenster_id,
    aktion_fg,
    dat_von,
    dat_bis,
    avg_menge,
    anz_tage_in_aktion)
    (
      SELECT
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        zeitfenster_id,
        aktion_fg,
        dat_von,
        dat_bis,
        avg_menge,
        anz_tage_in_aktion
      FROM dbp_etl.tmp_mk_art_wup_zeitfenster
      GROUP BY
        wup_id,
        nb_id,
        mandant_id,
        art_id,
        wtag_id,
        zeitfenster_id,
        aktion_fg,
        dat_von,
        dat_bis,
        avg_menge,
        anz_tage_in_aktion
    );
