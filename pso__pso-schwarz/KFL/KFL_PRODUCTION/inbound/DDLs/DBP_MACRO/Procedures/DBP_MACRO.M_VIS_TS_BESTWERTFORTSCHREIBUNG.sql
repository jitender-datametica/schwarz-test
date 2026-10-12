CREATE OR REPLACE PROCEDURE DBP_MACRO.M_VIS_TS_BESTWERTFORTSCHREIBUNG
(
 P_MANDANT_ID FLOAT 
,P_WUP_ID FLOAT 
,P_NB_ID FLOAT 
,P_DAT VARCHAR 
,P_OWG_ID FLOAT 
,P_WRG_ID VARCHAR 
,P_UMSATZ_PLAN_BRUTTO_OWG FLOAT 
,P_WARENEINGANG_BRUTTO_OWG FLOAT
,P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG FLOAT 
,P_SCHLUSSBESTAND_BRUTTO_OWG FLOAT
,P_ARTHIERTYP_ID FLOAT
)
RETURNS STRING 
LANGUAGE JAVASCRIPT 
EXECUTE AS OWNER 
AS
$$ 
 
var sql_stmt = `MERGE INTO dbp_msi_data.ts_bestwertfortschreibung target 
  USING (
    SELECT
     ? AS MANDANT_ID
    ,? AS WUP_ID
    ,? AS NB_ID
    ,? AS DAT
    ,? AS OWG_ID
    ,? AS ARTHIERTYP_ID
    ,? AS UMSATZ_PLAN_BRUTTO_OWG
    ,? AS SCHLUSSBESTAND_BRUTTO_OWG
    ,? AS WARENEINGANG_BRUTTO_OWG
    ,? AS SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,? AS WRG_ID
  ) source
    ON  target.mandant_id = source.mandant_id
    AND target.wup_id     = source.wup_id
    AND target.nb_id      = source.nb_id
    AND target.dat        = source.dat
    AND target.owg_id     = source.owg_id
    AND target.wrg_id     = source.wrg_id
  
  WHEN MATCHED THEN UPDATE 
    SET 
     target.UMSATZ_PLAN_BRUTTO_OWG             = source.UMSATZ_PLAN_BRUTTO_OWG
    ,target.SCHLUSSBESTAND_BRUTTO_OWG          = source.SCHLUSSBESTAND_BRUTTO_OWG
    ,target.WARENEINGANG_BRUTTO_OWG            = source.WARENEINGANG_BRUTTO_OWG
    ,target.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG = source.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,target.DATZEIT_PFLEGE = current_timestamp()
  
  WHEN NOT MATCHED THEN 
    INSERT (
     target.MANDANT_ID
    ,target.WUP_ID
    ,target.NB_ID
    ,target.DAT
    ,target.OWG_ID
    ,target.ARTHIERTYP_ID
    ,target.UMSATZ_PLAN_BRUTTO_OWG
    ,target.SCHLUSSBESTAND_BRUTTO_OWG
    ,target.WARENEINGANG_BRUTTO_OWG
    ,target.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,target.DATZEIT_PFLEGE 
    ,target.WRG_ID
    )
    VALUES (
     source.MANDANT_ID
    ,source.WUP_ID
    ,source.NB_ID
    ,source.DAT
    ,source.OWG_ID
    ,source.ARTHIERTYP_ID
    ,source.UMSATZ_PLAN_BRUTTO_OWG
    ,source.SCHLUSSBESTAND_BRUTTO_OWG
    ,source.WARENEINGANG_BRUTTO_OWG
    ,source.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,current_timestamp()
    ,source.WRG_ID
    )`;
 
snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_WUP_ID, P_NB_ID, P_DAT, P_OWG_ID, P_ARTHIERTYP_ID, P_UMSATZ_PLAN_BRUTTO_OWG, P_SCHLUSSBESTAND_BRUTTO_OWG, P_WARENEINGANG_BRUTTO_OWG, P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG, P_WRG_ID]
  // Anpassung für Snowflake, um NULL ins SQL zu übergeben
  .map(function(x){return x === undefined ? null : x})
}).execute();
 
 
var sql_commit = `COMMIT;`
 
snowflake.createStatement({
  sqlText : sql_commit
}).execute();
 
$$;