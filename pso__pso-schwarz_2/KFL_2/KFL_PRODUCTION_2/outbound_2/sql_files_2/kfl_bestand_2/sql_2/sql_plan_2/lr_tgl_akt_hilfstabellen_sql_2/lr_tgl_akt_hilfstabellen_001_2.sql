-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.mk_wupcal_2;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

CREATE TABLE IF NOT EXISTS dbp_etl.mk_wupcal_2(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  dat DATE,
  wtag_id INTEGER,
  offen INTEGER);

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_etl.mk_wupcal_2
  (mandant_id, wup_id, nb_id, dat, wtag_id, offen)
    (
      SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.dat,
        T02.wtag_id,
        T01.offen
      FROM dbp_data.wupcal_2 AS T01
      INNER JOIN dbp_data.tag_2 AS T02
        ON
          T01.dat = T02.dat
          AND T01.mandant_id = 1
          AND T01.nb_id = 0
          AND T02.wtag_id
            <> 7
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
-- WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

CREATE OR REPLACE TABLE dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}
  (
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

-- [OK] statement is translated correctly (syntax and type checks are fine)

-- Nur die nicht über Warengruppen erfassten Artikel_2
-- Nur Abteilung Food wird berücksichtigt
INSERT INTO dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}(
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
      0 AS aktiv_fg,
      anz_tage_0verkauf,
      CURRENT_DATE("Europe/Berlin") AS dat_von,
      PARSE_DATE('%F', '9999-12-31') AS dat_bis
    FROM dbp_data.mk_art_wup_auswahl_2 AS T01
    WHERE
      aktiv_fg = 1
      AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
      AND (mandant_id, art_id)
        NOT IN (
          SELECT (T02.mandant_id, T02.art_id)
          FROM dbp_data.art_2 AS T02
          INNER JOIN dbp_data.art_wg_zu_per_2 AS T03
            ON
              T02.mandant_id = T03.mandant_id
              AND T02.art_id = T03.art_id
              -- Aktuell gueltige Einträge der art_wg_zu_per_2
              AND T03.dat_bis = PARSE_DATE('%F', '9999-12-31')
              AND T03.arthiertyp_id
                = 2  -- Nur Artikel_2 aus aktueller Auswahl
          WHERE
            (T02.mandant_id, T02.art_id)
              IN (
                SELECT (mandant_id, art_id)
                FROM dbp_data.mk_art_wup_auswahl_2 AS T05
                WHERE
                  aktiv_fg = 1
                  AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
              )
            AND T02.wg_art_fg = 0  -- Ausschluss von Postenartikeln
            AND T02.posten_id = ''  -- Ausschluss Display
            AND T02.display_id = 0  -- Ausschluss von gelöschten Artikeln
            AND T02.loesch_id
              = ''  -- Ausschluss bestimmter Warengruppen aus der Abteilung Food
            AND (T03.mandant_id, T03.wg_id)
              IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_2
                WHERE
                  arthiertyp_id = 2
                  AND wg_filter_id = 8
              )
            AND (T03.mandant_id, T03.wg_id)
              NOT IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_2
                WHERE
                  arthiertyp_id = 2
                  AND wg_filter_id = 7
              )
          GROUP BY
            T02.mandant_id,
            T02.art_id
        )
  );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T01' does not exist or not authorized.

UPDATE dbp_data.mk_art_wup_auswahl_2 AS T01
SET
  dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
FROM
  dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}
    AS T02
WHERE
  T01.mandant_id = T02.mandant_id
  AND T01.wup_id = T02.wup_id
  AND T01.art_id = T02.art_id
  AND T01.wtag_id = T02.wtag_id
  AND T01.aktion_fg = T02.aktion_fg
  AND T01.aktiv_fg = 1
  AND CURRENT_DATE("Europe/Berlin") BETWEEN T01.dat_von AND T01.dat_bis;

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_data.mk_art_wup_auswahl_2
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
        dat_von,
        dat_bis,
        avg_menge,
        aktiv_fg,
        anz_tage_0verkauf,
        anz_tage_in_aktion
      FROM dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX} AS T01
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX};

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
-- WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

CREATE OR REPLACE TABLE dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}
  (
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

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}(
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
      0 AS aktiv_fg,
      anz_tage_0verkauf,
      CURRENT_DATE("Europe/Berlin") AS dat_von,
      PARSE_DATE('%F', '9999-12-31') AS dat_bis
    FROM dbp_data.mk_art_wup_auswahl_2 AS T01
    WHERE
      aktiv_fg = 1
      AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
      AND (mandant_id, wup_id, art_id)
        NOT IN (
          SELECT (T02.mandant_id, T02.wup_id, T02.art_id)
          FROM dbp_data.mk_art_wup_auswahl_2 AS T010
          INNER JOIN dbp_data.art_wup_zu_per_2 AS T02
            ON
              T010.mandant_id = T02.mandant_id
              AND T010.wup_id = T02.wup_id
              AND T010.art_id = T02.art_id
          WHERE
            T010.aktiv_fg = 1
            AND CURRENT_DATE("Europe/Berlin")
              BETWEEN T010.dat_von
              AND T010.dat_bis  -- Überprüfen ob Artikel_2 gelistet ist ...
            AND T02.listung_id = 1
            AND T02.bezugsweg_id IN (
              1, 4)  -- ... und das KDIS Kennzeichen auf 0 steht
            AND T02.kdis = 0
            AND CURRENT_DATE("Europe/Berlin")
              BETWEEN T02.dat_von
              AND T02.dat_bis
        )
      AND (mandant_id, wup_id, art_id)
        NOT IN (
          SELECT (mandant_id, wup_id, art_id)
          FROM dbp_data.art_wup_status_per_2
          WHERE
            dispomerkmal IN ('01', '11', 'ZZ')
            AND kdis = 0
            AND dat_bis = PARSE_DATE('%F', '9999-12-31')
          GROUP BY
            mandant_id,
            wup_id,
            art_id
        )
  );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T01' does not exist or not authorized.

UPDATE dbp_data.mk_art_wup_auswahl_2 AS T01
SET
  dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
FROM
  dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX}
    AS T02
WHERE
  T01.mandant_id = T02.mandant_id
  AND T01.wup_id = T02.wup_id
  AND T01.wtag_id = T02.wtag_id
  AND T01.art_id = T02.art_id
  AND T01.aktion_fg = T02.aktion_fg
  AND T01.aktiv_fg = 1
  AND CURRENT_DATE("Europe/Berlin") BETWEEN T01.dat_von AND T01.dat_bis;

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_data.mk_art_wup_auswahl_2
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
        dat_von,
        dat_bis,
        avg_menge,
        aktiv_fg,
        anz_tage_0verkauf,
        anz_tage_in_aktion
      FROM dbp_etl.mk_wup_art_auswahl_updt_$_2{TRANSIENT_TABLE_SUFFIX} AS T01
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.mk_promocal_2;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

CREATE TABLE IF NOT EXISTS dbp_etl.mk_promocal_2(
  mandant_id INTEGER,
  wup_id INTEGER,
  nb_id INTEGER,
  art_id INTEGER,
  dat DATE);

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_etl.mk_promocal_2
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
          FROM dbp_data.mk_art_wup_auswahl_2 AS T01
          INNER JOIN dbp_data.aktion_art_wup_zu_2 AS T02
            ON
              T01.mandant_id = T02.mandant_id
              AND T01.wup_id = T02.wup_id
              AND T01.nb_id = T02.nb_id
              AND T01.art_id = T02.art_id
          INNER JOIN dbp_data.aktion_2 AS T03
            ON
              T02.mandant_id = T03.mandant_id
              AND T02.aktion_id = T03.aktion_id
              AND T03.preisaktiviert_fg = 1
          INNER JOIN dbp_data.tag_2 AS T04
            ON T04.dat BETWEEN T03.dat_von AND T03.dat_bis
          WHERE
            T01.aktion_fg = 1
            AND T01.aktiv_fg = 1
            AND CURRENT_DATE("Europe/Berlin")
              BETWEEN T01.dat_von
              AND T01.dat_bis
            AND T02.grund_sperrung IS NULL
            AND T04.dat
              BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 7 DAY)
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
      INNER JOIN dbp_data.art_wup_zu_per_2 AS T06
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
