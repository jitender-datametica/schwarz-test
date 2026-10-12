CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REGION_2
--- MR 20.12.2011 erstellt
(
land_id
,region_id
,mandant_id
,sap_region_id
,region_name
)
AS
SELECT
 v01.land_id
,v01.region_id
,v01.mandant_id
,v01.sap_region_id
,v01.region_name

FROM dbp_view.v_region_2 v01
-- Anpassung wegen falscher Darstellung NSR4344843 / ssch1303 28.02.2024
JOIN dbp_view.v_mandant_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.mandant_kbez
WHERE v01.mandant_id <> 1;