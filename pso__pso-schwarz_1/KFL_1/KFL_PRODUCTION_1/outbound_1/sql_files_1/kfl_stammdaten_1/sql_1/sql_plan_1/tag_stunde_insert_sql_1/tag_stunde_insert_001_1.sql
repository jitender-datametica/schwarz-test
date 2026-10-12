--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_DATA.tag_stunde_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


TRUNCATE TABLE dbp_data.tag_stunde_1;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--original statement
--locking table DBX_DATA.tag_1 for access
--locking table DBX_DATA.zeit_1 for access
--INSERT INTO KFL_PRODUCTION.DBX_DATA.tag_stunde_1
--SELECT DISTINCT
--  v01.dat
--  ,v02.zeit_stunde AS stunde
--  ,CAST((v02.zeit_stunde (FORMAT '99')) AS STRING(2))||':00'AS stunde_minuten
--  ,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS STRING(2))||':00:00') AS timestamp_ntz(0) FORMAT 'yyyy-mm_1-ddBhh:mi:ss') AS dat_zeit
--FROM 
--DBX_DATA.tag_1 v01 --dbp_view.v_tag_1 
--cross join KFL_PRODUCTION.DBX_DATA.zeit_1 v02 --dbp_view.v_zeit_1
--WHERE v02.zeit_minute = 0
---- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!
--AND EXTRACT(HOUR FROM dat_zeit) = v02.zeit_stunde
--AND dat between date-2000 and date --order by 1 desc
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


-- dbp_view.v_zeit_1

-- ,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS STRING(2))||':00:00') AS timestamp_ntz(0) FORMAT 'yyyy-mm_1-ddBhh:mi:ss') AS dat_zeit

-- mfialkiewicz
-- dbp_view.v_tag_1
-- ,CAST((v02.zeit_stunde (FORMAT '99')) AS STRING(2))||':00'AS stunde_minuten

-- mfialkiewicz
INSERT INTO dbp_data.tag_stunde_1
(
    SELECT DISTINCT
        V01.dat,
        V02.zeit_stunde AS stunde,
        LPAD(CAST(V02.zeit_stunde AS STRING), 2, '0')
        || ':00' AS stunde_minuten,
        PARSE_DATETIME(
            '%F %I:%M:%S',
            CAST(V01.dat AS STRING)
            || ' '
            || LPAD(CAST(V02.zeit_stunde AS STRING), 2, '0')
            || ':00:00'
        ) AS dat_zeit,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.tag_1 AS V01
    INNER JOIN dbp_data.zeit_1 AS V02 ON TRUE
    WHERE
        -- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!
        V02.zeit_minute = 0

        AND EXTRACT(HOUR FROM PARSE_DATETIME('%F %I:%M:%S', CAST(
            V01.dat AS STRING) || ' ' || LPAD(
            CAST(V02.zeit_stunde AS STRING),
            2, '0'
        ) || ':00:00')) = V02.zeit_stunde
        -- order by 1 desc
        AND V01.dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 2000 DAY
        ) AND (CURRENT_DATE("Europe/Berlin")
        )
);
