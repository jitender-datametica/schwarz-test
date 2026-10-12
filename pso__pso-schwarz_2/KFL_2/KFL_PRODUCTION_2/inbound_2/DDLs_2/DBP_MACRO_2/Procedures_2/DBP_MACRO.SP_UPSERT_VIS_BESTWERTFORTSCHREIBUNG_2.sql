CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPSERT_VIS_BESTWERTFORTSCHREIBUNG(
	P_MANDANT_ID NUMBER(38,0),
	P_NB_ID NUMBER(38,0),
	P_WUP_ID NUMBER(38,0),
	P_DAT VARCHAR,
	P_OWG_ID NUMBER(38,0),
	P_WRG_ID VARCHAR,
	P_ARTHIERTYP_ID NUMBER(38,0),
	P_UMSATZ_PLAN_BRUTTO_OWG NUMBER(18,4),
	P_WARENEINGANG_BRUTTO_OWG NUMBER(18,4)
)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  $$

    
BEGIN
    MERGE INTO dbp_msi_data.ts_bestwertfortschreibung_2 target USING (
    SELECT
      :P_MANDANT_ID AS MANDANT_ID
    , :P_NB_ID AS NB_ID
    , :P_WUP_ID AS WUP_ID
    , :P_DAT AS DAT
    , :P_OWG_ID AS OWG_ID
    , :P_WRG_ID AS WRG_ID
    , :P_ARTHIERTYP_ID AS ARTHIERTYP_ID
    , :P_UMSATZ_PLAN_BRUTTO_OWG AS UMSATZ_PLAN_BRUTTO_OWG
    , :P_WARENEINGANG_BRUTTO_OWG AS WARENEINGANG_BRUTTO_OWG
    ) source
    ON  target.mandant_id = source.mandant_id
    AND target.wup_id     = source.wup_id
    AND target.dat        = source.dat
    AND target.owg_id     = source.owg_id
    AND target.wrg_id     = source.wrg_id
  
    WHEN MATCHED THEN UPDATE 
    SET
      target.UMSATZ_PLAN_BRUTTO_OWG = source.UMSATZ_PLAN_BRUTTO_OWG
    , target.WARENEINGANG_BRUTTO_OWG = source.WARENEINGANG_BRUTTO_OWG
    , target.DATZEIT_PFLEGE = CURRENT_TIMESTAMP()
  
    WHEN NOT MATCHED THEN 
    INSERT (
      target.MANDANT_ID
    , target.NB_ID
    , target.WUP_ID
    , target.DAT
    , target.OWG_ID
    , target.WRG_ID
    , target.ARTHIERTYP_ID
    , target.UMSATZ_PLAN_BRUTTO_OWG
    , target.WARENEINGANG_BRUTTO_OWG
    , target.DATZEIT_PFLEGE 
    )
    VALUES (
      source.MANDANT_ID
    , source.NB_ID
    , source.WUP_ID
    , source.DAT
    , source.OWG_ID
    , source.WRG_ID
    , source.ARTHIERTYP_ID
    , source.UMSATZ_PLAN_BRUTTO_OWG
    , source.WARENEINGANG_BRUTTO_OWG
    , CURRENT_TIMESTAMP()
    );
COMMIT;   
RETURN 'Eintrag wurde uebernommen';
END;
$$;