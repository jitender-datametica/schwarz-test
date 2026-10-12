create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_BEST_BLOCKBESTAND(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	PROZESS_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	MENGE_BLOCK,
	MENGE_BLOCK_WE,
	DAT_BEST_BELEG
) as 
    SELECT 
        mandant_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,prozess_id
        ,wup_id
        ,nb_id
        ,art_id
        ,menge_block
        ,menge_block_we
        ,dat_best_beleg


FROM DBP_DATA.best_blockbestand ;
