SELECT COUNT(*) FROM (
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_2' AND
        UPPER(table_name) = 'VIS_MONAT_BESTAND_WG_LOG_ALT_2'

);

