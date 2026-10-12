SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.TABLE_NAME
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_NAME) = 'KMO_ART_WUP_EK_DATUM_RELEVANT'
            AND upper(TABLES.TABLE_SCHEMA) = upper('DBP_ETL')
    ) AS subselect;
-- end subquery
