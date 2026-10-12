--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_zahlzeit_2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_agg_15min_zahlzeit_2 (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    zahlzeit INTEGER NOT NULL
);


--[OK] statement is translated correctly-----------------------------------------------------------------


-- (CASE WHEN zeit_scheibe_ende_<=end_time_ THEN zeit_scheibe_ende_ ELSE end_time_ END-CASE WHEN zeit_scheibe_start_>=start_time_ THEN zeit_scheibe_start_ ELSE start_time_ END) Second(4)) AS INTEGER)

-- ) AS  zahlzeit
-- Cast((
-- ,Sum(
INSERT INTO dbp_etl.ods_bon_agg_15min_zahlzeit_2 (
    dat, zeit_stunde,
    zeit_15min, mandant_id, wup_id, kassensystem_name, kasse_nr, kasse_typ_id, zahlzeit
)
(
    SELECT
        DATE(t1.bon_ende) AS bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        SUM(TIMESTAMP_DIFF(CASE
            WHEN
                DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_ende) || ' ' || T2.end_time), INTERVAL
                    1 SECOND
                ) <= CAST(SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19) AS DATETIME
                )
                THEN DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_ende) || ' ' || T2.end_time), INTERVAL
                    1 SECOND
                )
            ELSE CAST(SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19) AS DATETIME)
        END, CASE
            WHEN
                PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE(
                    '%F', t1.scan_ende) || ' ' || T2.start_time) >= CAST(SUBSTR(
                    CAST(t1.scan_ende AS STRING),
                    1, 19
                ) AS DATETIME)
                THEN PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.start_time)
            ELSE CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME)
        END, SECOND)) AS scanzeit
    FROM (SELECT
        mandant_id,
        wup_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        bon_dat,
        bon_beginn,
        scan_ende,
        bon_ende
    FROM dbp_etl.bon_agg_kassierzeiten_2
    WHERE DATE(bon_ende) = DATE(scan_ende)) AS t1_2
    INNER JOIN dbp_etl.`_zeit_$_2{TRANSIENT_TABLE_SUFFIX}` AS T2
        ON DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.bon_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.bon_ende AND PARSE_DATETIME('%F %H:%M:%S',
        FORMAT_DATETIME(
            '%F', t1.scan_ende) || ' ' || T2.start_time) <= t1.bon_ende OR DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.bon_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.scan_ende AND
        PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.start_time) <= t1.scan_ende
    WHERE
        CAST(
            SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME) < CAST(
            SUBSTR(CAST(t1.bon_ende AS STRING), 1, 19)
            AS DATETIME
        )
    GROUP BY
        bon_dat,
        T2.zeit_stunde,
        T2.zeit_minute,
        t1.mandant_id,
        t1.wup_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id
);
