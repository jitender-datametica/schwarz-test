CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_GEBIET(
	MANDANT_ID,
	GEBIET_ID,
	GEBIET_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v01.mandant_id, v01.gebiet_id, v02.gebiet_bez
   FROM dbp_view.v_immo_l_gebiet v01
   JOIN dbp_view.v_immo_gebiet_spr_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.gebiet_id = v02.gebiet_id
   AND v02.spr_id =22;