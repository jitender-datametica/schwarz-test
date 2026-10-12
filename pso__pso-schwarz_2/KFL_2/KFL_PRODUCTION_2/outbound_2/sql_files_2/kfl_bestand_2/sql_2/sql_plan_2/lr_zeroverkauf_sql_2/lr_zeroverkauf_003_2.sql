-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.mk_verkauf_2;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
-- WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.

CREATE TABLE IF NOT EXISTS dbp_etl.mk_verkauf_2(
  mandant_id INTEGER,
  wup_id INTEGER,
  art_id INTEGER,
  nb_id INTEGER,
  aktion_fg INTEGER,
  dat DATE,
  wtag_id INTEGER,
  zeitfenster_id INTEGER);

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.

-- Tabellen angepaßt
INSERT INTO dbp_etl.mk_verkauf_2
  (mandant_id, wup_id, art_id, nb_id, aktion_fg, dat, wtag_id, zeitfenster_id)
    (
      SELECT
        T01.mandant_id,
        T01.wup_id,
        t03.art_id,
        T02.nb_id,
        T02.aktion_fg,
        T01.bon_dat AS dat,
        T02.wtag_id,
        CASE
          WHEN EXTRACT(HOUR FROM T01.bon_booking) <= 11
            THEN 1
          WHEN EXTRACT(HOUR FROM T01.bon_booking) BETWEEN 12 AND 17
            THEN 2
          WHEN EXTRACT(HOUR FROM T01.bon_booking) >= 18
            THEN 3
          ELSE NULL
          END AS zeitfenster_id
      FROM dbp_ods.ods_bon_kopf_2 AS T01
      INNER JOIN dbp_ods.ods_bon_verkauf_2 AS T05
        ON
          T01.mandant_id = T05.mandant_id
          AND T01.wup_id = T05.wup_id
          AND T01.bon_id = T05.bon_id
          AND T01.bon_dat = T05.bon_dat
      INNER JOIN dbp_etl.akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX} AS T04
        ON
          T01.bon_dat = T04.dat
          AND T01.mandant_id = T04.mandant_id
          AND T01.wup_id = T04.wup_id
      INNER JOIN
        (
          SELECT
            kl_art_id,
            mandant_id,
            MAX(art_id) AS art_id
          FROM dbp_data.art_2
          GROUP BY
            mandant_id,
            kl_art_id
        ) AS t03
        ON T05.mandant_id = t03.mandant_id AND T05.kl_art_id = t03.kl_art_id
      INNER JOIN dbp_data.mk_art_wup_auswahl_2 AS T02
        ON
          T05.mandant_id = T02.mandant_id
          AND T05.wup_id = T02.wup_id
          AND t03.art_id = T02.art_id
          AND T04.dat BETWEEN T02.dat_von AND T02.dat_bis
          AND T04.wtag_id = T02.wtag_id
      WHERE T02.aktiv_fg = 1
      GROUP BY
        T01.mandant_id,
        T01.wup_id,
        t03.art_id,
        T02.nb_id,
        T02.aktion_fg,
        dat,
        T02.wtag_id,
        zeitfenster_id
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.mk_absatz_2;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

CREATE TABLE IF NOT EXISTS dbp_etl.mk_absatz_2(
  mandant_id INTEGER NOT NULL,
  art_id INTEGER,
  wup_id INTEGER,
  dat_bon DATE,
  zeit_bon INTEGER,
  sum_abs_stck NUMERIC(29, 4));

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.

INSERT INTO dbp_etl.mk_absatz_2
  (mandant_id, art_id, wup_id, dat_bon, zeit_bon, sum_abs_stck)
    (
      SELECT
        T01.mandant_id,
        a.art_id,
        T01.wup_id,
        T01.bon_dat,
        EXTRACT(HOUR FROM T01.bon_booking) * 10000
          + EXTRACT(MINUTE FROM T01.bon_booking) * 100
          + EXTRACT(SECOND FROM T01.bon_booking),
        SUM(T05.menge)
      FROM dbp_ods.ods_bon_kopf_2 AS T01
      INNER JOIN dbp_ods.ods_bon_verkauf_2 AS T05
        ON
          T01.mandant_id = T05.mandant_id
          AND T01.wup_id = T05.wup_id
          AND T01.bon_id = T05.bon_id
          AND T01.bon_dat = T05.bon_dat
      INNER JOIN
        (
          SELECT
            kl_art_id,
            MAX(art_id) AS art_id
          FROM dbp_data.art_2
          WHERE mandant_id = 1
          GROUP BY kl_art_id
        ) AS a
        ON T05.kl_art_id = a.kl_art_id
      WHERE
        T01.wup_id IN (SELECT wup_id FROM dbp_msi_data.l_mk_wup_2)
        AND T01.bon_dat = CURRENT_DATE("Europe/Berlin")
        AND T05.bon_dat = CURRENT_DATE("Europe/Berlin")
        AND T01.mandant_id = 1
      GROUP BY
        T01.mandant_id,
        a.art_id,
        T01.wup_id,
        T01.bon_dat,
        EXTRACT(HOUR FROM T01.bon_booking) * 10000
        + EXTRACT(MINUTE FROM T01.bon_booking) * 100
        + EXTRACT(SECOND FROM T01.bon_booking)
    );

-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.tmp_mk_marktbestand_erp_delta_2;

-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.

CREATE TABLE IF NOT EXISTS dbp_etl.tmp_mk_marktbestand_erp_delta_2(
  art_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  cal_menge_lgbest NUMERIC(29, 3) NOT NULL,
  lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL);

-- [OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO dbp_etl.tmp_mk_marktbestand_erp_delta_2
  (art_id, mandant_id, wup_id, cal_menge_lgbest, lgbest_erp_frei_bme)
    (
      SELECT
        TT01.art_id,
        TT01.mandant_id,
        TT01.wup_id,
        SUM(TT01.menge_lgbest_erp_frei_bme) - IFNULL(SUM(tt02.sum_abs_stck), 0)
          AS cal_menge_lgbest,
        SUM(TT01.menge_lgbest_erp_frei_bme) AS lgbest_erp_frei_bme
      FROM dbp_data.marktbestand_erp_delta_2 AS TT01
      INNER JOIN dbp_msi_data.l_mk_wup_2 AS TT03
        ON TT01.wup_id = TT03.wup_id
      LEFT JOIN
        (
          SELECT
            art_id,
            wup_id,
            mandant_id,
            SUM(sum_abs_stck) AS sum_abs_stck
          FROM dbp_etl.mk_absatz_2
          GROUP BY
            mandant_id,
            art_id,
            wup_id
        ) AS tt02
        ON
          TT01.art_id = tt02.art_id
          AND TT01.wup_id = tt02.wup_id
          AND TT01.mandant_id = tt02.mandant_id
      GROUP BY
        TT01.art_id,
        TT01.mandant_id,
        TT01.wup_id
    );

-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- DELETE    DBX_DATA.mk_zeroverkauf_2
-- WHERE (zeitfenster_id, dat, mandant_id, wup_id) IN
--
--      (SELECT zeitfenster_id, dat, mandant_id, wup_id
--        FROM ${akt_zeitfenster__OPENER_TRANSIENT_TABLE_SUFFIX_CLOSER_}
--      )
-- ;
--
-- Comment from validation checker
-- error line 1 at position 29 unexpected 'DBP_DATA_2'.
-- DELETE    DBP_DATA.mk_zerover ^^^> kauf
-- translated statement

DELETE FROM dbp_data.mk_zeroverkauf_2
WHERE
  (zeitfenster_id, dat, mandant_id, wup_id)
  IN (
    SELECT (zeitfenster_id, dat, mandant_id, wup_id)
    FROM dbp_etl.akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX}
  );

-- [OK] statement is translated correctly (syntax and type checks are fine)

-- Anheben Qaulifizierung für die Meldung in die Tagesliste bis avg_menge > 8
INSERT INTO dbp_data.mk_zeroverkauf_2
  (
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    dat,
    zeitfenster_id,
    aktion_fg,
    art_fehlgrund_id,
    menge_lgbest,
    datzeit_letzter_abverkauf,
    art_fehlgrund_text,
    dat_erfasst,
    melde_fg)
    (
      SELECT
        T01.wup_id,
        T01.nb_id,
        T01.mandant_id,
        T01.art_id,
        T01.dat,
        T02.zeitfenster_id,
        T01.aktion_fg,
        CAST(NULL AS INTEGER) AS art_fehlgrund_id,
        IFNULL(
          CASE
            WHEN T02.zeitfenster_id = 2
              THEN T07.cal_menge_lgbest
            ELSE T07.lgbest_erp_frei_bme
            END,
          0) AS menge_lgbest,
        CAST(NULL AS DATETIME) AS datzeit_letzter_abverkauf,
        SUBSTR(CAST(NULL AS STRING), 1, 500) AS art_fehlgrund_text,
        CAST(NULL AS DATETIME) AS dat_erfasst,
        CASE
          WHEN T08.mandant_id IS NULL
            THEN 0
          ELSE 1
          END AS melde_fg
      FROM dbp_etl.mk_wupartcal_2 AS T01
      INNER JOIN dbp_data.l_zeitfenster_2 AS T02
        ON T01.mandant_id = T02.mandant_id
      INNER JOIN dbp_etl.akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX} AS T03
        ON
          T02.zeitfenster_id = T03.zeitfenster_id
          AND T01.dat = T03.dat
          AND T01.mandant_id = T03.mandant_id
          AND T01.wup_id = T03.wup_id
      INNER JOIN dbp_data.mk_art_wup_auswahl_2 AS T06
        ON
          T01.wup_id = T06.wup_id
          AND T01.art_id = T06.art_id
          AND T01.wtag_id = T06.wtag_id
          AND T01.aktion_fg = T06.aktion_fg
          AND T01.dat BETWEEN T06.dat_von AND T06.dat_bis
      LEFT JOIN dbp_etl.tmp_mk_marktbestand_erp_delta_2 AS T07
        ON
          T01.wup_id = T07.wup_id
          AND T01.art_id = T07.art_id
          AND T01.mandant_id = T07.mandant_id
      LEFT JOIN dbp_data.mk_art_wup_zeitfenster_2 AS T08
        ON
          T01.mandant_id = T08.mandant_id
          AND T01.wup_id = T08.wup_id
          AND T01.art_id = T08.art_id
          AND T01.aktion_fg = T08.aktion_fg
          AND T01.wtag_id = T08.wtag_id
          AND T02.zeitfenster_id = T08.zeitfenster_id
          AND T01.dat BETWEEN T08.dat_von AND T08.dat_bis
      WHERE
        (
          CASE
            WHEN T08.mandant_id IS NULL
              THEN 0
            ELSE 1
            END = 1
          OR CASE
            WHEN T08.mandant_id IS NULL
              THEN 0
            ELSE 1
            END = 0 AND T06.avg_menge > 8)
        AND (
          T01.mandant_id,
          T01.wup_id,
          T01.art_id,
          T01.aktion_fg,
          T01.dat,
          T02.zeitfenster_id)
          NOT IN (
            SELECT (mandant_id, wup_id, art_id, aktion_fg, dat, zeitfenster_id)
            FROM dbp_etl.mk_verkauf_2 AS T04
          )
        AND (T01.mandant_id, T01.wup_id, T01.art_id, T01.aktion_fg, T01.wtag_id)
          NOT IN (
            SELECT (mandant_id, wup_id, art_id, aktion_fg, wtag_id)
            FROM dbp_data.mk_art_wup_auswahl_2 AS T05
            WHERE
              DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
                BETWEEN dat_von
                AND dat_bis
              AND anz_tage_0verkauf >= 3
          )
      GROUP BY
        T01.mandant_id,
        T01.art_id,
        T01.aktion_fg,
        T01.dat,
        T02.zeitfenster_id,
        T01.wup_id,
        T01.nb_id,
        art_fehlgrund_id,
        menge_lgbest,
        datzeit_letzter_abverkauf,
        art_fehlgrund_text,
        dat_erfasst,
        melde_fg
    );
