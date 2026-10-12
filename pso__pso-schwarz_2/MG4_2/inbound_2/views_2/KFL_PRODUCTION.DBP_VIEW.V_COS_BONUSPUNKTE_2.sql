create or replace view KFL_PRODUCTION.DBP_VIEW.V_COS_BONUSPUNKTE_2(
	CRM_KONTO_ID,
	DAT_VERFALL_BONUSPUNKTE,
	MANDANT_ID,
	ANZ_BONUSPUNKTE,
	DATZEIT_UPDATE
) as 
    SELECT 
        crm_konto_id,
        dat_verfall_bonuspunkte,
        mandant_id,
        anz_bonuspunkte,
        datzeit_update

FROM DBP_DATA.COS_BONUSPUNKTE_2 ;