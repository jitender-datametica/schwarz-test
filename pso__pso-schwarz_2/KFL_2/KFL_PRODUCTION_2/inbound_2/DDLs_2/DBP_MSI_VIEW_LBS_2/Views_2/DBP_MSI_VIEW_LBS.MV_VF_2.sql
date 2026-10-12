CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_VF_2(
	VF_ID,
	VF_NAME,
	MANDANT_ID
) AS SELECT
    vf_id,
    vf_name,
    mandant_id
FROM dbp_view.v_vf_2;