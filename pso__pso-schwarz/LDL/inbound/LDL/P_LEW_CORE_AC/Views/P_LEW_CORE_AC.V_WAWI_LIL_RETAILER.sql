create or replace view P_LEW_CORE_AC.V_WAWI_LIL_RETAILER(
	RTL_ID,
	RTL_DESC
) as
   SELECT
         rtl_id,
   rtl_desc
  FROM p_lew_core.t_wawi_lil_retailer
;

