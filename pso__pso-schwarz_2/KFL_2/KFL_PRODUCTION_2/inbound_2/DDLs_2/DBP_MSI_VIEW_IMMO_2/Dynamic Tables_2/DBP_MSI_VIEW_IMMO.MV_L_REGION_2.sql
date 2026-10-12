CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_REGION_2(
	MANDANT_ID,
	REGION_ID,
	SPR_ID,
	REGION_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.region_id, v2.spr_id, v2.region_bez

   FROM dbp_view.v_immo_l_region_2 v1
   JOIN dbp_view.v_immo_region_spr_zu_2 v2
   ON v1.mandant_id=v2.mandant_id AND v1.region_id=v2.region_id
   WHERE v2.spr_id=22
   ;