create or replace view PROCESS_MINING_PRODUCTION.EVAL.V_CMDB_CI_L2_REDUCED_TMP_1(
	ASSET
) as select cast( substr(asset, 0,3)as varchar(3))  as asset from eval.t_cmdb_ci_l2_reduced_1;