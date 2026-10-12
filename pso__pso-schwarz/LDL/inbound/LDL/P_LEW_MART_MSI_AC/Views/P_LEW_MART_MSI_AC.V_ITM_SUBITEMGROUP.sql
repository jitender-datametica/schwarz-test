create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_ITM_SUBITEMGROUP(
	SUBITEMGROUP_ID,
	MAINITEMGROUP_ID,
	ITEMGROUP_INT_ID,
	STATISTICGROUP_ID
) as
   SELECT
       subitemgroup_id,
   mainitemgroup_id,
   itemgroup_int_id,
   statisticgroup_id
   FROM p_lew_mart_msi.v_itm_subitemgroup;
