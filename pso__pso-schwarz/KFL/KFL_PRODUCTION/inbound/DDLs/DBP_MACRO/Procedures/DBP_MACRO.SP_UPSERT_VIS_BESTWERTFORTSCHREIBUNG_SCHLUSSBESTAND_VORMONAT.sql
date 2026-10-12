CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPSERT_VIS_BESTWERTFORTSCHREIBUNG_SCHLUSSBESTAND_VORMONAT(
    P_MANDANT_ID NUMBER(38,0),
	P_NB_ID NUMBER(38,0),
	P_WUP_ID NUMBER(38,0),
	P_DAT VARCHAR,
	P_OWG_ID NUMBER(38,0),
	P_WRG_ID VARCHAR,
	P_ARTHIERTYP_ID NUMBER(38,0),
	P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG NUMBER(18,4)
)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS OWNER
AS  $$
BEGIN 

MERGE INTO dbp_msi_data.ts_bestwertfortschreibung target 
  USING (
    SELECT
     :P_MANDANT_ID AS MANDANT_ID
    ,:P_WUP_ID AS WUP_ID
    ,:P_NB_ID AS NB_ID
    ,:P_DAT AS DAT
    ,:P_OWG_ID AS OWG_ID
    ,:P_ARTHIERTYP_ID AS ARTHIERTYP_ID
    ,:P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG AS SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,:P_WRG_ID AS WRG_ID
  ) source
    ON  target.mandant_id = source.mandant_id
    AND target.wup_id     = source.wup_id
    AND target.nb_id      = source.nb_id
    AND target.dat        = source.dat
    AND target.owg_id     = source.owg_id
    AND target.wrg_id     = source.wrg_id
  
  WHEN MATCHED THEN UPDATE 
    SET 
    target.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG = source.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,target.DATZEIT_PFLEGE = current_timestamp()
  
  WHEN NOT MATCHED THEN 
    INSERT (
     target.MANDANT_ID
    ,target.WUP_ID
    ,target.NB_ID
    ,target.DAT
    ,target.OWG_ID
    ,target.ARTHIERTYP_ID
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
    ,source.SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
    ,current_timestamp()
    ,source.WRG_ID
    );

 
 
COMMIT;
RETURN 'Abgespeichert';
END;
$$;