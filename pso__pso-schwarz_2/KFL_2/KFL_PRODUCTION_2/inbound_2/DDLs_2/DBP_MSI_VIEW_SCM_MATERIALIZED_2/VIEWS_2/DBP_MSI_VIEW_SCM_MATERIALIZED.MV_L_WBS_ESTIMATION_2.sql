create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_WBS_ESTIMATION_2(
	ESTIMATION_ID,
	ESTIMATION_BEZ
) as
SELECT 
 estimation_id
,estimation_bez
FROM dbp_view.v_wbs_l_estimation_2
GROUP BY estimation_id, estimation_bez;