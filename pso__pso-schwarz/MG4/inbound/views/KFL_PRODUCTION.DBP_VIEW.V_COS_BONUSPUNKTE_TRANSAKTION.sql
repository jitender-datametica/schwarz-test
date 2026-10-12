create or replace view KFL_PRODUCTION.DBP_VIEW.V_COS_BONUSPUNKTE_TRANSAKTION(
	CRM_KONTO_ID,
	DATZEIT_BONUSPUNKTE_TRANSAKTION,
	MANDANT_ID,
	BONUSPUNKTE_TRANSAKTION_ID,
	ANZ_BONUSPUNKTE_TRANSAKTION,
	BONUSPUNKTE_TRANSAKTION_RICHTUNG,
	DATZEIT_UPDATE
) as 
    SELECT 
        crm_konto_id,
        datzeit_bonuspunkte_transaktion,
        mandant_id,
        bonuspunkte_transaktion_id,
        anz_bonuspunkte_transaktion,
        bonuspunkte_transaktion_richtung,
        datzeit_update

FROM DBP_DATA.COS_BONUSPUNKTE_TRANSAKTION ;