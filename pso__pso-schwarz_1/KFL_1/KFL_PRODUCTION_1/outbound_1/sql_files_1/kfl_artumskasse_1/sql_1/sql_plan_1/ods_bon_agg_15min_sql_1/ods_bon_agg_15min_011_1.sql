--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_kassierzeit_1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_agg_15min_kassierzeit_1 (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    wup_id INTEGER NOT NULL,
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    kassierzeit INTEGER NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TABLE dbp_etl.`_track_it_$_1{TRANSIENT_TABLE_SUFFIX} ` AS
SELECT
    T1.mandant_id,
    T1.kassensystem_name,
    T1.wup_id,
    T1.kasse_nr,
    T1.kasse_typ_id,
    t2.zeit_stunde,
    t2.zeit_minute,
    DATE(T1.start_time) AS bon_dat,
    PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING) || ' ' || t2.start_time) AS zeit_scheibe_start,
    DATETIME_ADD(
        PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING) || ' ' || t2.end_time), INTERVAL 1
        SECOND
    ) AS zeit_scheibe_ende,
    T1.start_time,
    T1.end_time
FROM dbp_etl.ods_bon_sign_on_off_time_1 AS T1_1
INNER JOIN (SELECT
    zeit_stunde,
    zeit_minute,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 10))
    END || ':00' AS start_time,
    CASE
        WHEN zeit_stunde < 10
            THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
        ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 10))
    END || ':' || CASE
        WHEN zeit_minute = 0
            THEN '14:59'
        WHEN zeit_minute = 15
            THEN '29:59'
        WHEN zeit_minute = 30
            THEN '44:59'
        WHEN zeit_minute = 45
            THEN '59:59'
        ELSE NULL
    END AS end_time
FROM dbp_data.zeit_1) AS t2 ON DATETIME_ADD(PARSE_DATETIME(
    '%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING)
    || ' ' || t2.end_time
), INTERVAL 1 SECOND) >= T1.start_time AND PARSE_DATETIME('%F %H:%M:%S', CAST(DATE(T1.start_time) AS STRING
)
|| ' ' || t2.start_time) <= T1.end_time;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_etl.`_track_it_$_1{TRANSIENT_TABLE_SUFFIX} `
WHERE LPAD(
    CAST(EXTRACT(HOUR FROM end_time) AS STRING), 2, '0') || ':' || LPAD(
    CAST(EXTRACT(MINUTE FROM end_time) AS STRING),
    2, '0'
) || ':' || LPAD(CAST(EXTRACT(SECOND FROM end_time) AS STRING), 2, '0'
) = '23:59:59';


--[OK] statement is translated correctly-----------------------------------------------------------------


INSERT INTO dbp_etl.ods_bon_agg_15min_kassierzeit_1 (
    dat, zeit_stunde, zeit_15min, mandant_id,
    kassensystem_name, wup_id, kasse_nr, kasse_typ_id, kassierzeit
)
(
    SELECT
        bon_dat,
        zeit_stunde,
        zeit_minute,
        mandant_id,
        kassensystem_name,
        wup_id,
        kasse_nr,
        kasse_typ_id,
        SUM(TIMESTAMP_DIFF(CASE
            WHEN zeit_scheibe_ende <= end_time
                THEN zeit_scheibe_ende
            ELSE end_time
        END, CASE
            WHEN zeit_scheibe_start >= start_time
                THEN zeit_scheibe_start
            ELSE start_time
        END, SECOND)) AS kassierzeit
    FROM dbp_etl.`_track_it_$_1{TRANSIENT_TABLE_SUFFIX} `
    GROUP BY
        bon_dat,
        zeit_stunde,
        zeit_minute,
        mandant_id,
        kassensystem_name,
        wup_id,
        kasse_nr,
        kasse_typ_id
);
