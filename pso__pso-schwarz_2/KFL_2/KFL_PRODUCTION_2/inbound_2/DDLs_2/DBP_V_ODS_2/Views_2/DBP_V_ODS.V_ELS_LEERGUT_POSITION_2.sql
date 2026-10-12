create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_V_ODS.V_ELS_LEERGUT_POSITION_2(
	BARCODE_LEERGUT,
	MANDANT_ID,
	BON_ZEILE,
	MWST_ID,
	WRG_ID,
	KL_ART_ID,
	MENGE,
	BON_ZEILEN_WERT,
	PLU_GRUPPE
) as 
    SELECT 
        barcode_leergut
        ,mandant_id
        ,bon_zeile
        ,mwst_id
        ,wrg_id
        ,kl_art_id
        ,menge
        ,bon_zeilen_wert
        ,plu_gruppe
FROM DBP_ODS.els_leergut_position_2 ;
