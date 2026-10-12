CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_REGION_1
(
land_id
, region_id
, mandant_id
, sap_region_id
, region_name
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
 v01.land_id
,v01.region_id
,v01.mandant_id
,v01.sap_region_id
,v01.region_name

FROM dbp_view.v_region_1 v01
-- Anpassung wegen falscher Darstellung NSR4344843 / ssch1303 28.02.2024
JOIN (SELECT mandant_id,
      CASE WHEN mandant_id = 1 THEN 'DE' ELSE mandant_kbez END AS land_id
      FROM dbp_view.v_mandant_1) v02
ON v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.land_id;