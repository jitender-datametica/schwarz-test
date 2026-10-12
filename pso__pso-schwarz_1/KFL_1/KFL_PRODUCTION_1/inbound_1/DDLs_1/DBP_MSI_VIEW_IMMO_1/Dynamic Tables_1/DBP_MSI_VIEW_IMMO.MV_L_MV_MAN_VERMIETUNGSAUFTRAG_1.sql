CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MV_MAN_VERMIETUNGSAUFTRAG_1(
	MAN_VERMIETUNGSAUFTRAG_ID,
	MAN_VERMIETUNGSAUFTRAG_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.man_vermietungsauftrag_id, v0.man_vermietungsauftrag_bez
   FROM dbp_view.v_immo_l_man_vermietungsauftrag_1 v0
   WHERE mandant_id = 1;