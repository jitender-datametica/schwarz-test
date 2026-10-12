CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_ZEN (MANDANT_ID FLOAT, WUP_ID FLOAT, NB_ID FLOAT, DAT DATE, UMS_NETTO_PLAN_MAN FLOAT, STUNDEN_MARKT FLOAT, STUNDEN_SONSTIGE FLOAT, STUNDEN_VERSETZUNG FLOAT, STUNDEN_PLAN FLOAT, STUNDEN_SONSTIGE_PLAN FLOAT, SPERRE_WOCHE_SO FLOAT, SPERRE_MONAT_7 FLOAT, SPERRE_MONAT_15 FLOAT, SPERRE_LAND FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var sql_stmt = `MERGE INTO dbp_data.wup_stunden_tag_1 USING
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
ELSE CASE WHEN v02.stunden_sonstige = 0 THEN null ELSE v02.stunden_sonstige END
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
AND dat          = ?
) v01

LEFT JOIN dbp_view.v_wup_stunden_tag_1 v02
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

) using_select ON  DBP_VIEW.v_wup_stunden_tag_transaktion.wup_id     = using_select.wup_id
AND DBP_VIEW.v_wup_stunden_tag_transaktion.nb_id      = using_select.nb_id
AND DBP_VIEW.v_wup_stunden_tag_transaktion.mandant_id = using_select.mandant_id
AND DBP_VIEW.v_wup_stunden_tag_transaktion.dat        = using_select.dat

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
   binds : [SPERRE_WOCHE_SO,UMS_NETTO_PLAN_MAN, 
            SPERRE_LAND,SPERRE_MONAT_15,STUNDEN_MARKT, 
            MANDANT_ID,SPERRE_MONAT_7,STUNDEN_SONSTIGE, 
            MANDANT_ID,SPERRE_MONAT_15,STUNDEN_SONSTIGE, 
            MANDANT_ID,SPERRE_MONAT_15,STUNDEN_VERSETZUNG, 
            SPERRE_WOCHE_SO,STUNDEN_PLAN, 
            MANDANT_ID,SPERRE_WOCHE_SO,STUNDEN_SONSTIGE_PLAN, 
            MANDANT_ID,SPERRE_MONAT_15,STUNDEN_SONSTIGE_PLAN, 
            MANDANT_ID,WUP_ID,NB_ID,DAT.toISOString()]
}).execute();

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;
