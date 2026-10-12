CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_FIL_temp
 (IN_MANDANT_ID FLOAT, IN_WUP_ID FLOAT, IN_NB_ID FLOAT, IN_DAT DATE, IN_UMS_NETTO_PLAN_MAN FLOAT
, IN_STUNDEN_MARKT FLOAT, IN_STUNDEN_SONSTIGE FLOAT, IN_STUNDEN_VERSETZUNG FLOAT, IN_STUNDEN_PLAN FLOAT, IN_STUNDEN_SONSTIGE_PLAN FLOAT
, IN_SPERRE_WOCHE_SO FLOAT, IN_SPERRE_MONAT_7 FLOAT, IN_SPERRE_MONAT_15 FLOAT, IN_SPERRE_LAND FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_data.wup_stunden_tag_1 as A USING
( -- using select
SELECT
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.dat,
v03.wrg_id,
CASE
            WHEN ? = 0 THEN Coalesce(?, v02.ums_netto_plan_man)
            ELSE v02.ums_netto_plan_man
          END AS ums_netto_plan_man,
CASE
            WHEN ? = 0 AND ? = 0 THEN Coalesce(?, v02.stunden_markt)
            ELSE v02.stunden_markt
          END AS stunden_markt,
CASE
            WHEN ? = 1  AND ? = 0  THEN Coalesce(?, v02.stunden_sonstige)
            WHEN ? <> 1 AND ? = 0 THEN Coalesce(?, v02.stunden_sonstige)
            ELSE CASE WHEN v02.stunden_sonstige = 0 THEN null ELSE v02.stunden_sonstige END
END AS stunden_sonstige,
CASE
          WHEN ? <> 1 AND ? = 0 THEN Coalesce(?, v02.stunden_versetzung)
          ELSE v02.stunden_versetzung
        END AS stunden_versetzung,
CASE
          WHEN ? = 0 THEN Coalesce(?, v02.stunden_plan)
          ELSE v02.stunden_plan
        END AS stunden_plan,
CASE
        WHEN ? = 1  AND ? = 0 THEN Coalesce(?, v02.stunden_sonstige_plan)
        WHEN ? <> 1 AND ? = 0 THEN Coalesce(?, v02.stunden_sonstige_plan)
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

) as using_select ON  A.wup_id     = using_select.wup_id
AND A.nb_id      = using_select.nb_id
AND A.mandant_id = using_select.mandant_id
AND A.dat        = using_select.dat

WHEN MATCHED THEN UPDATE
SET
wrg_id                = using_select.wrg_id
,ums_netto_plan_man    = Abs(using_select.ums_netto_plan_man) -- Alle
,stunden_markt         = using_select.stunden_markt           -- NOT USED (all)
,stunden_sonstige      = using_select.stunden_sonstige        -- NOT USED (Ausland)
,stunden_versetzung    = using_select.stunden_versetzung      -- NOT USED (all)
,stunden_plan          = Abs(using_select.stunden_plan)       -- Alle
,stunden_sonstige_plan = CASE WHEN using_select.mandant_id IN (2, 5, 8) THEN Abs(using_select.stunden_sonstige_plan) ELSE using_select.stunden_sonstige_plan END -- CZ/SK/BG

WHEN NOT MATCHED THEN INSERT
(
wup_id
,nb_id
,mandant_id
,dat
,wrg_id
,ums_netto_plan
,ums_netto_plan_man
,stunden_markt
,stunden_sonstige
,stunden_versetzung
,stunden_plan
,stunden_sonstige_plan
,stunden_plan_pep
,stunden_co1_iks
,stunden_co2_ea
,stunden_co3_anue
,stunden_co4_reinigung
,stunden_co5_sonstige
)
VALUES
(
 using_select.wup_id
,using_select.nb_id
,using_select.mandant_id
,using_select.dat
,using_select.wrg_id
,0.00
,Abs(using_select.ums_netto_plan_man)
,using_select.stunden_markt
,using_select.stunden_sonstige
,Coalesce(using_select.stunden_versetzung, 0)
,Abs(using_select.stunden_plan)
,CASE WHEN using_select.mandant_id IN (2, 5, 8) THEN Abs(using_select.stunden_sonstige_plan) ELSE using_select.stunden_sonstige_plan end
,0
,0
,0
,0
,0
,0
)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [IN_SPERRE_WOCHE_SO,IN_UMS_NETTO_PLAN_MAN,IN_SPERRE_LAND,IN_SPERRE_MONAT_15,IN_STUNDEN_MARKT,IN_MANDANT_ID,IN_SPERRE_MONAT_7,IN_STUNDEN_SONSTIGE,IN_MANDANT_ID,IN_SPERRE_MONAT_15,IN_STUNDEN_SONSTIGE,IN_MANDANT_ID,IN_SPERRE_MONAT_15,IN_STUNDEN_VERSETZUNG,IN_SPERRE_WOCHE_SO,IN_STUNDEN_PLAN,IN_MANDANT_ID,IN_SPERRE_WOCHE_SO,IN_STUNDEN_SONSTIGE_PLAN,IN_MANDANT_ID,IN_SPERRE_MONAT_15,IN_STUNDEN_SONSTIGE_PLAN,IN_MANDANT_ID,IN_WUP_ID,IN_NB_ID,IN_DAT.toISOString()]
      .map(function(x){return x === undefined ? null : x})
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;