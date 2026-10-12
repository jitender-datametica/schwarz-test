CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_FIL_MD (
-- Makro zur Pflege der Tabelle wup_stunden_tag_1 - Variante Filiale (FIL)
-- (Variante Zentrale = m_ups_wup_stunden_tag_ZEN)
-- Wenn Sperre (sperre = 1) gesetzt, wird immer der vorhandene Originalwert aus der Tabelle genommen, ansonsten der Eingabewert
-- Sperre Monat_1 > Stunden_1 IST (AUSL) + Stunden_1 IST Sonst (INT) + Stunden_1 Versetzung (AUSL)
-- Sperre Woche_1 > Umsatz Pflege (INT) + Stunden_1 Plan (INT) + Stunden_1 Plan sonst (INT)
-- Die anderen Inhalte der Tabelle werden nicht per Transaction gepflegt. Wichtig: Insert benoetigt Waehrung aus vorhanden Daten, daher kein Parameter.
-- 2017.0116 ssch0611 : neuer Parameter (3. Eingabesperre) + CASE fuer Stunden_1 Plan (DE) ergaenzt + Anpassung stunden_plan_sonstige (analog stunden_sonstige)
-- 2017.0516 ssch0611 : Review Leistung = zwei Sperren (andere Inhalte) + CASE Logik International + neue Spalten/Felder
-- 2017.0710 ssch0611 : neues Macro-Objekt (FIL). 3 Sperren (Zeit_1) + 1 Sperre (Land_1) + Unterscheidung DE/Ausland
 MANDANT_ID FLOAT
, WUP_ID FLOAT
, NB_ID FLOAT
, DAT STRING
, UMS_NETTO_PLAN_MAN FLOAT
, STUNDEN_MARKT FLOAT
, STUNDEN_SONSTIGE FLOAT
, STUNDEN_VERSETZUNG FLOAT
, STUNDEN_PLAN FLOAT
, STUNDEN_SONSTIGE_PLAN FLOAT
, SPERRE_WOCHE_SO FLOAT
, SPERRE_MONAT_7 FLOAT
, SPERRE_MONAT_15 FLOAT
, SPERRE_LAND FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 
 	//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var sql_stmt = `MERGE INTO dbp_data.wup_stunden_tag_MD_1 USING
( -- using select
SELECT
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.dat,
v03.wrg_id,
CASE
WHEN ? = 0 THEN COALESCE(?, v02.ums_netto_plan_man)
ELSE v02.ums_netto_plan_man
END AS ums_netto_plan_man,
CASE
WHEN ? = 0 AND ? = 0 THEN COALESCE(?, v02.stunden_markt)
ELSE v02.stunden_markt
END AS stunden_markt,
CASE
WHEN ? = 1  AND ? = 0  THEN COALESCE(?, v02.stunden_sonstige)
WHEN ? <> 1 AND ? = 0 THEN COALESCE(?, v02.stunden_sonstige)
ELSE NULLIFZERO(v02.stunden_sonstige)
END AS stunden_sonstige,
CASE
WHEN ? <> 1 AND ? = 0 THEN COALESCE(?, v02.stunden_versetzung)
ELSE v02.stunden_versetzung
END AS stunden_versetzung,
CASE
WHEN ? = 0 THEN COALESCE(?, v02.stunden_plan)
ELSE v02.stunden_plan
END AS stunden_plan,
CASE
WHEN ? = 1  AND ? = 0 THEN COALESCE(?, v02.stunden_sonstige_plan)
WHEN ? <> 1 AND ? = 0 THEN COALESCE(?, v02.stunden_sonstige_plan)
ELSE v02.stunden_sonstige_plan
END AS stunden_sonstige_plan
FROM
( -- v01
SELECT
v01_2.wup_id,
v01_2.nb_id,
v01_2.mandant_id,
v01_1.dat
FROM dbp_data.tag_1 v01_1
CROSS JOIN dbp_data.wup_1 v01_2
WHERE mandant_id = ?
AND wup_id       = ?
AND nb_id        = ?
AND dat          = TO_DATE(?)
) v01

LEFT JOIN dbp_data.wup_stunden_tag_MD_1 v02
ON v01.wup_id      = v02.wup_id
AND v01.nb_id      = v02.nb_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat        = v02.dat

LEFT JOIN
(SELECT
mandant_id,
wrg_id
FROM dbp_data.mandant_wrg_typ_zu_1
WHERE wrg_typ_id = 1
) v03
ON v01.mandant_id = v03.mandant_id

) using_select 
ON  dbp_data.wup_stunden_tag_MD.wup_id     = using_select.wup_id
AND dbp_data.wup_stunden_tag_MD.nb_id      = using_select.nb_id
AND dbp_data.wup_stunden_tag_MD.mandant_id = using_select.mandant_id
AND dbp_data.wup_stunden_tag_MD.dat        = using_select.dat

WHEN MATCHED THEN UPDATE
SET
wrg_id                   = using_select.wrg_id
, ums_netto_plan_man     = using_select.ums_netto_plan_man
, stunden_markt          = using_select.stunden_markt
, stunden_sonstige       = using_select.stunden_sonstige
, stunden_versetzung     = using_select.stunden_versetzung
, stunden_plan           = using_select.stunden_plan
, stunden_sonstige_plan  = using_select.stunden_sonstige_plan

WHEN NOT MATCHED THEN INSERT
(wup_id
, nb_id
, mandant_id
, dat
,wrg_id
,ums_netto_plan
, ums_netto_plan_man
, stunden_markt
, stunden_sonstige
, stunden_versetzung
, stunden_plan
, stunden_sonstige_plan
,stunden_plan_pep
,stunden_co1_iks
,stunden_co2_ea
,stunden_co3_anue
,stunden_co4_reinigung
,stunden_co5_sonstige
)
VALUES
(
using_select.wup_Id
,using_select.nb_id
,using_select.mandant_id
,using_select.dat
,using_select.wrg_id
,0.00
,using_select.ums_netto_plan_man
,using_select.stunden_markt
,using_select.stunden_sonstige
,COALESCE(using_select.stunden_versetzung, 0)
,using_select.stunden_plan
,using_select.stunden_sonstige_plan
,0
,0
,0
,0
,0
,0
)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [SPERRE_WOCHE_SO
            ,UMS_NETTO_PLAN_MAN
            ,SPERRE_LAND
            ,SPERRE_MONAT_15
            ,STUNDEN_MARKT
            ,MANDANT_ID
            ,SPERRE_MONAT_7
            ,STUNDEN_SONSTIGE
            ,MANDANT_ID
            ,SPERRE_MONAT_15
            ,STUNDEN_SONSTIGE
            ,MANDANT_ID
            ,SPERRE_MONAT_15
            ,STUNDEN_VERSETZUNG
            ,SPERRE_WOCHE_SO
            ,STUNDEN_PLAN
            ,MANDANT_ID
            ,SPERRE_WOCHE_SO
            ,STUNDEN_SONSTIGE_PLAN
            ,MANDANT_ID
            ,SPERRE_MONAT_15
            ,STUNDEN_SONSTIGE_PLAN
            ,MANDANT_ID
            ,WUP_ID
            ,NB_ID
            ,DAT].map(function(x){return x === undefined ? null : x})
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();



$$;

