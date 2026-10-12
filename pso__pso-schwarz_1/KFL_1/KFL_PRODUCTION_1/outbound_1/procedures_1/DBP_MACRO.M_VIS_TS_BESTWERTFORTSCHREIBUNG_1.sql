CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_ts_bestwertfortschreibung(IN P_MANDANT_ID FLOAT64, IN P_WUP_ID FLOAT64, IN P_NB_ID FLOAT64, IN P_DAT STRING, IN P_OWG_ID FLOAT64, IN P_WRG_ID STRING, IN P_UMSATZ_PLAN_BRUTTO_OWG FLOAT64, IN P_WARENEINGANG_BRUTTO_OWG FLOAT64, IN P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG FLOAT64, IN P_ARTHIERTYP_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_msi_data.ts_bestwertfortschreibung_1 AS TARGET USING (SELECT @P_MANDANT_ID AS mandant_id,   @P_WUP_ID AS wup_id,   @P_NB_ID AS nb_id,   @P_DAT AS dat,   @P_OWG_ID AS owg_id,   @P_ARTHIERTYP_ID AS arthiertyp_id,   @P_UMSATZ_PLAN_BRUTTO_OWG AS umsatz_plan_brutto_owg,   @P_WARENEINGANG_BRUTTO_OWG AS wareneingang_brutto_owg,   @P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG AS schlussbestand_vormonat_brutto_owg,   @P_WRG_ID AS wrg_id) AS source ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.nb_id = source.nb_id AND TARGET.dat      = CAST(source.dat AS DATE) AND TARGET.owg_id = source.owg_id AND TARGET.wrg_id = source.wrg_id WHEN MATCHED THEN UPDATE SET  umsatz_plan_brutto_owg = CAST(ROUND(CAST(source.umsatz_plan_brutto_owg AS BIGNUMERIC), 0) AS NUMERIC),  wareneingang_brutto_owg = CAST(ROUND(CAST(source.wareneingang_brutto_owg AS BIGNUMERIC), 0) AS NUMERIC),  schlussbestand_vormonat_brutto_owg = CAST(ROUND(CAST(source.schlussbestand_vormonat_brutto_owg AS BIGNUMERIC), 0) AS   NUMERIC),  datzeit_pflege = CURRENT_TIMESTAMP() WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id, wrg_id, umsatz_plan_brutto_owg,  wareneingang_brutto_owg, schlussbestand_vormonat_brutto_owg, datzeit_pflege) VALUES(CAST(source.mandant_id AS INTEGER)  , CAST(source.wup_id AS INTEGER), CAST(source.nb_id AS INTEGER), CAST(source.dat AS DATE), CAST(source.owg_id AS INTEGER)  , CAST(source.arthiertyp_id AS INTEGER), source.wrg_id, CAST(ROUND(CAST(source.umsatz_plan_brutto_owg AS BIGNUMERIC), 0    ) AS NUMERIC), CAST(ROUND(CAST(source.wareneingang_brutto_owg AS BIGNUMERIC), 0) AS NUMERIC), CAST(ROUND(CAST(source.schlussbestand_vormonat_brutto_owg AS BIGNUMERIC)    , 0) AS NUMERIC), CURRENT_TIMESTAMP()) ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_WUP_ID AS P_WUP_ID,  P_NB_ID AS P_NB_ID,  P_DAT AS P_DAT,  P_OWG_ID AS P_OWG_ID,  P_ARTHIERTYP_ID AS P_ARTHIERTYP_ID,  P_UMSATZ_PLAN_BRUTTO_OWG AS P_UMSATZ_PLAN_BRUTTO_OWG,  P_WARENEINGANG_BRUTTO_OWG AS P_WARENEINGANG_BRUTTO_OWG,  P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG AS P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG,  P_WRG_ID AS P_WRG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
