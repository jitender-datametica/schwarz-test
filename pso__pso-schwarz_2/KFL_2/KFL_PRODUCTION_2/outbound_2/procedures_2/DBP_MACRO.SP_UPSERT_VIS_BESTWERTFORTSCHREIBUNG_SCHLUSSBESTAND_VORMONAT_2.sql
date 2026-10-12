CREATE OR REPLACE PROCEDURE dbp_macro.sp_upsert_vis_bestwertfortschreibung_schlussbestand_vormonat(IN P_MANDANT_ID INT64, IN P_NB_ID INT64, IN P_WUP_ID INT64, IN P_DAT STRING, IN P_OWG_ID INT64, IN P_WRG_ID STRING, IN P_ARTHIERTYP_ID INT64, IN P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG NUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_data.ts_bestwertfortschreibung_2 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_WUP_ID AS wup_id, P_NB_ID AS nb_id, P_DAT AS dat, P_OWG_ID AS owg_id, P_ARTHIERTYP_ID AS arthiertyp_id, P_SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG AS schlussbestand_vormonat_brutto_owg, P_WRG_ID AS wrg_id) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.nb_id = source.nb_id AND TARGET.dat = CAST(source.dat AS DATE) AND TARGET.owg_id = source.owg_id AND TARGET.wrg_id = source.wrg_id
WHEN MATCHED THEN UPDATE SET
    schlussbestand_vormonat_brutto_owg = source.schlussbestand_vormonat_brutto_owg,
    datzeit_pflege = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id, wrg_id, schlussbestand_vormonat_brutto_owg, datzeit_pflege) VALUES(source.mandant_id, source.wup_id, source.nb_id, CAST(source.dat AS DATE), source.owg_id, source.arthiertyp_id, source.wrg_id, source.schlussbestand_vormonat_brutto_owg, CAST(CURRENT_TIMESTAMP() AS DATETIME));
COMMIT TRANSACTION;
SET out_param  =  'Abgespeichert';
SELECT out_param;
RETURN;
END;