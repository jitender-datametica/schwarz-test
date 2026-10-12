CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ART_GP_AKTUELL(
	ART_ID,
	AKT_GP_ID,
	MANDANT_ID,
	WUP_ID
) AS SELECT
    art_id,
    gp_id,
    mandant_id,
    wup_id
FROM dbp_view.v_art_gp_nm_zu_per
WHERE  dat_bis = '9999-12-31'
GROUP BY 1,2,3,4;