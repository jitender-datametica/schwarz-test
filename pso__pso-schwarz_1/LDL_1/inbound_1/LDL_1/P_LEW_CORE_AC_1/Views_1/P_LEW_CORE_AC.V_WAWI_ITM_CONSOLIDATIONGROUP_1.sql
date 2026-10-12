create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_ITM_CONSOLIDATIONGROUP_1(
	CLIENT_ID,
	WH_LOC_SID,
	ITM_CONSGRP_ID,
	DAT_REC_START,
	DAT_REC_END,
	ITM_CONSGRP_DESC,
	DAT_MODIFICATION,
	TIMESTAMP_FN,
	LOAD_ID
) as
   SELECT
       client_id,
   wh_loc_sid,
   itm_consgrp_id,
   dat_rec_start,
   dat_rec_end,
   itm_consgrp_desc,
   dat_modification,
   timestamp_fn,
   load_id
   FROM p_lew_core.t_wawi_itm_consolidationgroup_1;
