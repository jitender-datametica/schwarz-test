CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_WBS_ESTIMATION_1(
	ESTIMATION_ID,
	ESTIMATION_BEZ
) AS
SELECT 
 estimation_id
,estimation_bez
FROM dbp_view.v_wbs_l_estimation_1
GROUP BY estimation_id, estimation_bez;