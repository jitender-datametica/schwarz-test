CREATE OR REPLACE PROCEDURE dbp_macro.sp_upsert_vis_bestwertfortschreibung(IN P_MANDANT_ID INT64, IN P_NB_ID INT64, IN P_WUP_ID INT64, IN P_DAT STRING, IN P_OWG_ID INT64, IN P_WRG_ID STRING, IN P_ARTHIERTYP_ID INT64, IN P_UMSATZ_PLAN_BRUTTO_OWG NUMERIC, IN P_WARENEINGANG_BRUTTO_OWG NUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_data.ts_bestwertfortschreibung AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_NB_ID AS nb_id, P_WUP_ID AS wup_id, P_DAT AS dat, P_OWG_ID AS owg_id, P_WRG_ID AS wrg_id, P_ARTHIERTYP_ID AS arthiertyp_id, P_UMSATZ_PLAN_BRUTTO_OWG AS umsatz_plan_brutto_owg, P_WARENEINGANG_BRUTTO_OWG AS wareneingang_brutto_owg) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.dat = CAST(source.dat AS DATE) AND TARGET.owg_id = source.owg_id AND TARGET.wrg_id = source.wrg_id
WHEN MATCHED THEN UPDATE SET
    umsatz_plan_brutto_owg = source.umsatz_plan_brutto_owg,
    wareneingang_brutto_owg = source.wareneingang_brutto_owg,
    datzeit_pflege = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id, wrg_id, umsatz_plan_brutto_owg, wareneingang_brutto_owg, datzeit_pflege) VALUES(source.mandant_id, source.wup_id, source.nb_id, CAST(source.dat AS DATE), source.owg_id, source.arthiertyp_id, source.wrg_id, source.umsatz_plan_brutto_owg, source.wareneingang_brutto_owg, CAST(CURRENT_TIMESTAMP() AS DATETIME));
COMMIT TRANSACTION;
SET out_param  =  'Eintrag wurde uebernommen';
SELECT out_param;
RETURN;
END;
