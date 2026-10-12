CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_L_ADJUSTMENT_2(
	ADJUSTMENT_ID,
	ADJUSTMENT_BEZ
) AS
--2025-05-27, dknop, initial
SELECT 
 adjustment_id
,adjustment_bez
FROM dbp_view.v_wbs_l_adjustment_2
GROUP BY adjustment_id,adjustment_bez
;