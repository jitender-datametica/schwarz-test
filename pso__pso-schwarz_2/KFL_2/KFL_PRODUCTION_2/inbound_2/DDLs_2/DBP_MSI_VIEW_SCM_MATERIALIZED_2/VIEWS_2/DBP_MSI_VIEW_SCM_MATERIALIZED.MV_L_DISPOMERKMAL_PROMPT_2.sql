create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_DISPOMERKMAL_PROMPT_2(
	DISPOMERKMAL
) as
SELECT v01.dispomerkmal
FROM DBP_VIEW.v_l_dispomerkmal_2 v01
GROUP BY v01.dispomerkmal;