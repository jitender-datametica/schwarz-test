create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_LEIST_2(
	LEIST_ID,
	LEIST_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   CASE WHEN leist_id='' THEN 'keine' ELSE leist_id END, leist_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_leist_2
   WHERE leist_id NOT IN ('N','N2','N3','O1','O2','O3','WA','WB','WC','WD')
   AND mandant_id = 1
   AND spr_id = 22;