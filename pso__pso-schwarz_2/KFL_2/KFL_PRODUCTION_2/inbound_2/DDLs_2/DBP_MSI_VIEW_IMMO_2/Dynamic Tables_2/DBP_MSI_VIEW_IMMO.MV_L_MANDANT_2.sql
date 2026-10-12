CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MANDANT_2(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	MANDANT_SAP_ID,
	DEFAULT_WRG,
	MANDANT_SORT_ID,
	SORT_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.mandant_id, CASE WHEN v0.mandant_id=7 THEN 'Rumänien' ELSE v0.mandant_bez END AS mandant_bez, v0.mandant_kbez, v0.mandant_sap_id, v0.default_wrg, v0.mandant_sort_id, CASE  WHEN v0.mandant_id=1 THEN 1
   WHEN v0.mandant_id=2 THEN 2
   WHEN v0.mandant_id=3 THEN 4
   WHEN v0.mandant_id=4 THEN 8
   WHEN v0.mandant_id=5 THEN 3
   WHEN v0.mandant_id=6 THEN 5
   WHEN v0.mandant_id=7 THEN 6
   WHEN v0.mandant_id=8 THEN 7
   ELSE 9 END AS sort_id
   FROM dbp_view.v_mandant_2 v0;