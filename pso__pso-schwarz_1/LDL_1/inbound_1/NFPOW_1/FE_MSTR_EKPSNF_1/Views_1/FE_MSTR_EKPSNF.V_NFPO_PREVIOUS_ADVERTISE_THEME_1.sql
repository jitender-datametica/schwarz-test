CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_NFPO_PREVIOUS_ADVERTISE_THEME_1(
	 nfpo_adv_theme_sid
	,nfpo_prev_adv_theme_lvl_nr
	,nfpo_prev_adv_theme_sid
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
)AS 
(SELECT
	 nfpo_adv_theme_sid
	,nfpo_prev_adv_theme_lvl_nr
	,nfpo_prev_adv_theme_sid
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE_REL.T_NFPO_PREVIOUS_ADVERTISE_THEME_1
);