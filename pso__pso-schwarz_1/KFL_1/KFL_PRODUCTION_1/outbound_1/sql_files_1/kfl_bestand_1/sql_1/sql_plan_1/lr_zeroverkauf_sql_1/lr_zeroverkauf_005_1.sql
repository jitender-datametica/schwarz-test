-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T01' does not exist or not authorized.

UPDATE dbp_data.mk_art_wup_auswahl_1 AS T01
SET
  anz_tage_0verkauf = 0
FROM dbp_etl.akt_zeitfenster_$_1{TRANSIENT_TABLE_SUFFIX} AS T02
WHERE
  (T01.mandant_id, T01.wup_id, T01.art_id)
    IN (SELECT (mandant_id, wup_id, art_id) FROM dbp_etl.mk_verkauf_1 AS T02)
  AND T02.dat BETWEEN T01.dat_von AND T01.dat_bis
  AND T02.mandant_id
    = T01.mandant_id
  AND T02.wup_id = T01.wup_id
  AND T02.wtag_id = T01.wtag_id
  AND T01.aktiv_fg = 1
  AND T01.aktion_fg
    = 0;

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

-- Comment from validation checker
-- MESSAGE: SQL compilation error:
-- Object 'T01' does not exist or not authorized.

UPDATE dbp_data.mk_art_wup_auswahl_1 AS T01
SET
  anz_tage_0verkauf = T01.anz_tage_0verkauf + 1
FROM
  dbp_etl.akt_zeitfenster_$_1{TRANSIENT_TABLE_SUFFIX}
    AS T02
WHERE
  (T01.mandant_id, T01.wup_id, T01.art_id)
    IN (
      SELECT (mandant_id, wup_id, art_id)
      FROM dbp_etl.mk_wupartcal_1 AS T03
      WHERE
        dat IN (
          SELECT dat
          FROM dbp_etl.akt_zeitfenster_$_1{TRANSIENT_TABLE_SUFFIX} AS T04
        )
    )
  AND T02.dat BETWEEN T01.dat_von AND T01.dat_bis
  AND T02.mandant_id = T01.mandant_id
  AND T02.wup_id = T01.wup_id
  AND T02.wtag_id = T01.wtag_id
  AND T01.aktiv_fg = 1
  AND T01.aktion_fg = 0
  AND (T01.mandant_id, T01.wup_id, T01.art_id)
    NOT IN (SELECT (mandant_id, wup_id, art_id) FROM dbp_etl.mk_verkauf_1 AS T02);
