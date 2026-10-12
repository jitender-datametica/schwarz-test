create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_SM_2(
	SM_ID,
	SM_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   sm_id, sm_bez, mandant_id, spr_id

   FROM dbp_view.v_sm_2
   WHERE mandant_id = 1
   AND sm_id <> -9
;