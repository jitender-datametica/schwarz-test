CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_BUCHUNGSKREIS_2(
	MANDANT_ID,
	BUCHUNGSKREIS_ID,
	BUCHUNGSKREIS_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, CASE WHEN v1.buchungskreis_id < 10 THEN '000' || TRIM(v1.buchungskreis_id)
   WHEN v1.buchungskreis_id < 100 THEN '00' || TRIM(v1.buchungskreis_id)
   WHEN v1.buchungskreis_id < 1000 THEN '0' || TRIM(v1.buchungskreis_id)
   ELSE '' || TRIM(v1.buchungskreis_id)
 END AS buchungskreis_id, v2.buchungskreis_bez


   FROM dbp_view.v_in_l_buchungskreis_2 v1
   LEFT JOIN dbp_view.v_in_buchungskreis_spr_zu_2 v2
   ON v1.mandant_id = v2.mandant_id AND v1.buchungskreis_id = v2.buchungskreis_id;