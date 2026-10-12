--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.regio_polygon_adresse_zu_2
WHERE adresse_id NOT IN (
    SELECT adresse_id
    FROM dbp_data.wup_2
    WHERE mandant_id = 1
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE KFL_PRODUCTION.schema.table ...)


CREATE TEMPORARY TABLE IF NOT EXISTS _kill_40 AS
SELECT
    mandant_id,
    adresse_id,
    COUNT(DISTINCT regio_stufe_id) AS anzahl
FROM dbp_data.regio_polygon_adresse_zu_2
WHERE regio_stufe_id IN (40, 41)
GROUP BY
    mandant_id,
    adresse_id
HAVING anzahl = 2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.regio_polygon_adresse_zu_2
WHERE (
    mandant_id, adresse_id, regio_stufe_id) IN (
    SELECT (mandant_id, adresse_id, 40)
    FROM `_kill_40`
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.regio_polygon_adresse_zu_2 SET
    regio_stufe_id = 40
FROM `_kill_40` AS b
WHERE
    regio_polygon_adresse_zu.mandant_id = b.mandant_id
    AND regio_polygon_adresse_zu.adresse_id = b.adresse_id
    AND regio_polygon_adresse_zu.regio_stufe_id = 41;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.regio_polygon_adresse_zu_2 SET
    regio_stufe_id = 40
WHERE regio_stufe_id = 41;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.regio_art_gp_wup_zu_2 SET
    regio_stufe_id = 40
WHERE regio_stufe_id = 41;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.regio_polygon_art_gp_zu_2 SET
    regio_stufe_id = 40
WHERE regio_stufe_id = 41;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.regio_polygon_spr_zu_2 SET
    regio_stufe_id = 40
WHERE regio_stufe_id = 41;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.l_regio_polygon_2 SET
    regio_stufe_id = 40
WHERE regio_stufe_id = 41;
