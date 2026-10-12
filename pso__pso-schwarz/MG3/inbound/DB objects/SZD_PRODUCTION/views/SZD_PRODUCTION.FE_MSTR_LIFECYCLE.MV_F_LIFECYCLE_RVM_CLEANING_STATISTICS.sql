create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CLEANING_STATISTICS(
	RVM_SID,
	CLEANING_TYPE_CD,
	CLEANING_STATUS_CD,
	BEGIN_OF_CLEANING_DT,
	CLEANING_DUR_SEC_CNT
) as 
SELECT 
 Core.t_fact_rvm_cleaning.rvm_sid
,Core.t_fact_rvm_cleaning.cleaning_type_cd
,Core.t_fact_rvm_cleaning.cleaning_status_cd
,Core.t_fact_rvm_cleaning.begin_of_cleaning_dt
,Core.t_fact_rvm_cleaning.cleaning_dur_sec_cnt
FROM 
Core.t_fact_rvm_cleaning
;