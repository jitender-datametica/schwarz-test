create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ABT_SPR_ZU_2(
	MANDANT_ID,
	ABT_ID,
	ARTHIERTYP_ID,
	SPR_ID,
	ABT_BEZ
) as
   SELECT
   mandant_id, abt_id, arthiertyp_id, spr_id, abt_bez

   FROM dbp_view.v_abt_spr_zu_2

   WHERE spr_id = 22
   AND arthiertyp_id = 2
   AND mandant_id = 1
   AND abt_id BETWEEN -3 AND 8;