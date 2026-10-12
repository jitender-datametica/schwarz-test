CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_KUEND_PARTEI_1(
	KUEND_PARTEI,
	KUEND_PARTEI_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT DISTINCT
   '1' AS kuend_partei, 'Vertragsnehmer' AS kuend_partei_bez
   FROM dbp_view.v_mandant_1

   UNION ALL

   SELECT DISTINCT
   '2' AS kuend_partei, 'Vertragsgeber' AS kuend_partei_bez
   FROM dbp_view.v_mandant_1

   UNION ALL

   SELECT DISTINCT
   '9' AS kuend_partei, 'Beide' AS kuend_partei_bez
   FROM dbp_view.v_mandant_1

   UNION ALL

   SELECT DISTINCT
   '' AS kuend_partei, '' AS kuend_partei_bez
   FROM dbp_view.v_mandant_1;