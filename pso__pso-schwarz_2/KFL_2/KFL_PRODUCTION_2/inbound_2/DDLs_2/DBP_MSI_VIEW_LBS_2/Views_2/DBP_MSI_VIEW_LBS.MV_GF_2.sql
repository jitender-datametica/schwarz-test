CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GF_2(
	GF_ID,
	MANDANT_ID,
	EK_FG,
	GF_NAME
) AS SELECT
    gf_id,
    mandant_id,
    ek_fg,
    gf_name
FROM dbp_view.v_gf_2
WHERE ek_fg = 0;