create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_SERVICE_OPERATIONS(
	RVM_SID,
	PREV_ACTION_DT,
	RVM_PREV_ACTION_TYPE_ID
) as SELECT
 core.t_fact_rvm_prev_actions.rvm_sid
,core.t_fact_rvm_prev_actions.prev_action_dt
,core.t_fact_rvm_prev_actions.rvm_prev_action_type_id
FROM 
core.t_fact_rvm_prev_actions
GROUP BY 
 rvm_sid,prev_action_dt
,rvm_prev_action_type_id
;