create or replace view KFL_PRODUCTION.DBP_VIEW.V_CRM_GUTSCHEIN(
	MANDANT_ID,
	CRM_GUTSCHEIN_ID,
	CRM_VORGANG_ID,
	CRM_GUTSCHEIN_GRUND_ID,
	GUTSCHEIN_NUMMER,
	KOSTENSTELLE_ID,
	GUTSCHEIN_WERT,
	WRG_ID
) as 
    SELECT 
        mandant_id
        ,crm_gutschein_id
        ,crm_vorgang_id
        ,crm_gutschein_grund_id
        ,gutschein_nummer
        ,kostenstelle_id
        ,gutschein_wert
        ,wrg_id


FROM DBP_DATA.crm_gutschein ;