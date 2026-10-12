-- Folgende Tabelle nur anlegen, wenn sie noch nicht vorhanden ist.
-- Der Inhalt wird durch die Verarbeitung gesteuert.
-- Die Tabelle dient als Zwischenspeicher der Markttage die
-- fuer das Aggregat art_bestand_vw_sum benoetigt werden


SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL' AND
        UPPER(table_name) = 'KMO_WPUUMS_ART_GP_WUP_ZU'
--end subquery

);

