CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WBL_2(
	WBL_ID,
	MANDANT_ID,
	WBL_DAT_VON,
	WBL_NAME,
	GF_ID,
	EK_FG
) AS SELECT
    wbl_id,
    mandant_id,
    wbl_dat_von,
    wbl_name,
    gf_id,
    ek_fg
FROM dbp_view.v_wbl_2;