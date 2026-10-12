CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_REGION_2(
	LAND_ID,
	REGION_ID,
	MANDANT_ID,
	SAP_REGION_ID,
	REGION_NAME
) AS SELECT
    v01.land_id
    ,v01.region_id
    ,v01.mandant_id
    ,v01.sap_region_id
    ,v01.region_name
FROM dbp_view.v_region_2 v01
-- Anpassung wegen falscher Darstellung NSR4344843 / ssch1303 28.02.2024
JOIN (SELECT mandant_id,
    CASE WHEN mandant_id = 1 THEN 'DE' ELSE mandant_kbez END AS land_id
    FROM dbp_view.v_mandant_2) v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.land_id = v02.land_id;