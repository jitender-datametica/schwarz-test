CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_RANGE_SELECTION_2(
	 nfpo_range_sel_sid
	,nfpo_range_sel_nr
	,nfpo_range_plan_nr
	,nfpo_range_sel_cal_month
	,nfpo_range_sel_cal_year
	,nfpo_range_sel_deliv_from_cal_week
	,nfpo_range_sel_deliv_to_cal_week
	,nfpo_range_sel_adv_from_cal_week
	,nfpo_range_sel_adv_to_cal_week
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_range_sel_sid
	,nfpo_range_sel_nr
	,nfpo_range_plan_nr
	,nfpo_range_sel_cal_month
	,nfpo_range_sel_cal_year
	,nfpo_range_sel_deliv_from_cal_week
	,nfpo_range_sel_deliv_to_cal_week
	,nfpo_range_sel_adv_from_cal_week
	,nfpo_range_sel_adv_to_cal_week
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_RANGE_SELECTION_2
);