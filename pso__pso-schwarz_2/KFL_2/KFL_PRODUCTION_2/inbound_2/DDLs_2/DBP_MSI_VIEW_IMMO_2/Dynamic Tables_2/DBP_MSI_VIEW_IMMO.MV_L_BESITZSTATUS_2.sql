CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_BESITZSTATUS_2(
	MANDANT_ID,
	BESITZSTATUS_ID,
	BESITZSTATUS_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.besitzstatus_id, v2.besitzstatus_bez
   FROM dbp_view.v_immo_l_besitzstatus_2 AS v1
   JOIN dbp_view.v_immo_besitzstatus_spr_zu_2 AS v2
   ON v1.mandant_id=v2.mandant_id AND v1.besitzstatus_id=v2.besitzstatus_id
   WHERE v2.spr_id=22;