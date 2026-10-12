--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_scanzeit_1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_agg_15min_scanzeit_1 (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    scanzeit INTEGER NOT NULL
);


--[OK] statement is translated correctly-----------------------------------------------------------------


-- ) AS  scanzeit
-- ,Sum(

-- (CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END-CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END) Second(4)) AS INTEGER)

-- Cast((
INSERT INTO dbp_etl.ods_bon_agg_15min_scanzeit_1 (
    dat, zeit_stunde, zeit_15min, mandant_id,
    wup_id, kassensystem_name, kasse_nr, kasse_typ_id, scanzeit
)
(
    SELECT
        DATE(t1.bon_beginn) AS bon_dat,
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
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.end_time),
                    INTERVAL 1 SECOND
                ) <= CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME
                )
                THEN DATETIME_ADD(
                    PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.scan_ende) || ' ' || T2.end_time),
                    INTERVAL 1 SECOND
                )
            ELSE CAST(SUBSTR(CAST(t1.scan_ende AS STRING), 1, 19) AS DATETIME)
        END, CASE
            WHEN
                PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE(
                    '%F', t1.bon_beginn) || ' ' || T2.start_time) >= CAST(SUBSTR(
                    CAST(t1.bon_beginn AS STRING),
                    1, 19
                ) AS DATETIME)
                THEN PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATE('%F', t1.bon_beginn) || ' ' || T2.start_time)
            ELSE CAST(SUBSTR(CAST(t1.bon_beginn AS STRING), 1, 19) AS DATETIME)
        END, SECOND)) AS scanzeit
    FROM (
        SELECT
            mandant_id,
            wup_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            bon_beginn,
            scan_ende,
            bon_ende
        FROM dbp_etl.bon_agg_kassierzeiten_1
        WHERE
            DATE(bon_beginn) = DATE(scan_ende)
            AND bon_beginn < scan_ende
    ) AS t1_1
    INNER JOIN dbp_etl.`_zeit_$_1{TRANSIENT_TABLE_SUFFIX}` AS T2
        ON DATETIME_ADD(PARSE_DATETIME(
            '%F %H:%M:%S',
            FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.end_time
        ), INTERVAL 1 SECOND) >= t1.scan_ende AND
        PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.bon_beginn) || ' ' || T2.start_time) <= t1.scan_ende OR
        DATETIME_ADD(
            PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.scan_ende) || ' ' || T2.end_time), INTERVAL 1
            SECOND
        ) >= t1.bon_beginn AND PARSE_DATETIME('%F %H:%M:%S', FORMAT_DATETIME('%F', t1.bon_beginn) || ' ' || T2.start_time
        ) <= t1.bon_beginn
    WHERE T2.start_time < T2.end_time
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
