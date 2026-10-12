CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_EK_GF_1(
	GF_ID,
	MANDANT_ID,
	EK_FG,
	GF_NAME
) AS SELECT
    gf_id,
    mandant_id,
    ek_fg,
    gf_name
FROM dbp_view.v_gf_1
WHERE ek_fg = 1;