SELECT count(*)
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_2'
            AND upper(TABLES.TABLE_NAME) = 'VIS_MONAT_BESTAND_WG_LOG_ALT_2'
    ) AS subselect;
