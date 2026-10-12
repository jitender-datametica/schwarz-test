create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_1(
	AMX_SYSTEM_ID,
	ORGA_EINHEIT_ID,
	ORGA_EINHEIT_IMP_REFERENZ,
	ORGA_EINHEIT_BEZ,
	MANDANT_ID,
	WUP_ID,
	NB_ID
) as 
    SELECT 
        amx_system_id
        ,orga_einheit_id
        ,orga_einheit_imp_referenz
        ,orga_einheit_bez
        ,mandant_id
        ,wup_id
        ,nb_id


FROM DBP_DATA.KMR_L_ORGANISATIONSEINHEIT_1 ;