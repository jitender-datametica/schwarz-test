CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MV_VERTRAGSART_1(
	VERTRAGSART_ID,
	VERTRAGSART_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.vertragsart_id, v1.vertragsart_bez
   FROM dbp_view.v_immo_l_vertragsart_1 v0
   JOIN dbp_view.v_immo_vertragsart_spr_zu_1 v1
   ON v0.mandant_id = v1.mandant_id
   AND v0.vertragsart_id = v1.vertragsart_id
   AND v1.spr_id = 22
   WHERE v0.mandant_id = 1

   UNION ALL

   SELECT
   0 AS vertragsart_id, '' AS vertragsart_bez
   FROM dbp_view.v_mandant_1 WHERE mandant_id = 1;