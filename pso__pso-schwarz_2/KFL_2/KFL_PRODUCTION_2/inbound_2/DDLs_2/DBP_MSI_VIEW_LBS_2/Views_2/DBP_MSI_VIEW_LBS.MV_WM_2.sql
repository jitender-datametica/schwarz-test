CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WM_2(
	WM_ID,
	WM_NAME,
	MANDANT_ID
) AS SELECT
    wm_id,
    wm_name,
    mandant_id
FROM dbp_view.v_wm_2;