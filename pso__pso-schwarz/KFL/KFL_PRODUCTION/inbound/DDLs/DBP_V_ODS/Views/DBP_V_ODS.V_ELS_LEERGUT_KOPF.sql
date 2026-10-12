create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_V_ODS.V_ELS_LEERGUT_KOPF(
	BARCODE_LEERGUT,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	BON_DAT,
	WRG_ID,
	BON_TMSP,
	BON_NR,
	SYSTEM_BEZ,
	SYSTEM_TYP_BEZ,
	SYSTEM_HERSTELLER_BEZ,
	BON_WERT
) as 
    SELECT 
        barcode_leergut
        ,mandant_id
        ,wup_id
        ,nb_id
        ,bon_dat
        ,wrg_id
        ,bon_tmsp
        ,bon_nr
        ,system_bez
        ,system_typ_bez
        ,system_hersteller_bez
        ,bon_wert
FROM DBP_ODS.els_leergut_kopf ;
