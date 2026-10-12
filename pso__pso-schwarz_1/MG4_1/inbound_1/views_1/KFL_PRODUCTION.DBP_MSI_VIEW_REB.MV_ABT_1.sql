create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ABT_1(
	MANDANT_ID,
	ABT_ID,
	ARTHIERTYP_ID
) as
   SELECT
   mandant_id, abt_id, arthiertyp_id

   FROM dbp_view.v_abt_1

   WHERE arthiertyp_id = 2
   AND mandant_id = 1
   AND abt_id BETWEEN -3 AND 8
;