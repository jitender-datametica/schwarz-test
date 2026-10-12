--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.regio_polygon_adresse_zu_1
WHERE adresse_id NOT IN (SELECT adresse_id
                         FROM DBP_DATA.wup_1
                         WHERE mandant_id = 1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE Volatile TABLE _kill_40 AS (
SELECT mandant_id,
       adresse_id,
       COUNT(DISTINCT regio_stufe_id) AS anzahl
FROM DBP_DATA.regio_polygon_adresse_zu_1
WHERE regio_stufe_id IN (40,41)
GROUP BY 1,2
HAVING COUNT(DISTINCT regio_stufe_id) = 2
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.regio_polygon_adresse_zu_1
WHERE (mandant_id,adresse_id,regio_stufe_id) IN (SELECT mandant_id,adresse_id,40 FROM _kill_40)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.regio_polygon_adresse_zu_1 
SET regio_stufe_id = 40

FROM (SELECT *
                                               FROM _kill_40) b
											    WHERE DBP_DATA.regio_polygon_adresse_zu.mandant_id = b.mandant_id AND
      DBP_DATA.regio_polygon_adresse_zu.adresse_id = b.adresse_id AND
      DBP_DATA.regio_polygon_adresse_zu.regio_stufe_id = 41
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.regio_polygon_adresse_zu_1 SET regio_stufe_id = 40
WHERE regio_stufe_id = 41
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.regio_art_gp_wup_zu_1 SET regio_stufe_id = 40
WHERE regio_stufe_id = 41
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.regio_polygon_art_gp_zu_1 SET regio_stufe_id = 40
WHERE regio_stufe_id = 41
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.regio_polygon_spr_zu_1 SET regio_stufe_id = 40
WHERE regio_stufe_id = 41
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.l_regio_polygon_1 SET regio_stufe_id = 40
WHERE regio_stufe_id = 41
;

