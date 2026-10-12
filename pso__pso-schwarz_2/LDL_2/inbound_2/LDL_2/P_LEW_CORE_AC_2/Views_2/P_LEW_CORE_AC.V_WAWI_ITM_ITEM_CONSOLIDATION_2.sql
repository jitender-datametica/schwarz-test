create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_ITM_ITEM_CONSOLIDATION_2(
	CLIENT_ID,
	WH_LOC_SID,
	ITEM_SID,
	DAT_REC_START,
	DAT_REC_END,
	ITM_CONSGRP_ID,
	DAT_MODIFICATION,
	TIMESTAMP_FN,
	LOAD_ID
) as
   SELECT
       client_id,
   wh_loc_sid,
   item_sid,
   dat_rec_start,
   dat_rec_end,
   itm_consgrp_id,
   dat_modification,
   timestamp_fn,
   load_id
   FROM p_lew_core.t_wawi_itm_item_consolidation_2;
