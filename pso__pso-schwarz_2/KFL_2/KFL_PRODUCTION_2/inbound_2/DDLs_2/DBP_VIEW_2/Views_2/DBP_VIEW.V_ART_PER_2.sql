create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_PER_2(
	ART_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	MUTTER_WB_ID,
	POSTEN_ID,
	IPN_ID,
	MWST_ID,
	OUG_ID,
	IWT_ID
) as 
    SELECT 
        art_id,
        mandant_id,
        dat_von,
        dat_bis,
        mutter_wb_id,
        posten_id,
        ipn_id,
        mwst_id,
        oug_id,
        iwt_id

FROM DBP_DATA.ART_PER_2 ;
