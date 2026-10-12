CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ART_GP_NM_ZU_PER_1(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_VON,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	DAT_BIS
) AS SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    dat_bis
FROM dbp_view.v_art_gp_nm_zu_per_1;