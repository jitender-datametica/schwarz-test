-- Folgende Tabelle nur anlegen, wenn sie noch nicht vorhanden ist.
-- Der Inhalt wird durch die Verarbeitung gesteuert.
-- Die Tabelle dient als Zwischenspeicher der Markttage die
-- fuer das Aggregat art_bestand_vw_sum_1 benoetigt werden
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_1'
            AND upper(TABLES.TABLE_NAME) = 'KMO_WPUUMS_ART_GP_WUP_ZU_1'
    ) AS subselect;
-- end subquery
