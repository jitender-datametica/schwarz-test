CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_NACHLIEFERUNGSPROCESS_MAERKTE
AS
SELECT
v1.mandant_id
,CASE 
WHEN gp_id = 10015214 THEN 'RETAILZOOM' 
WHEN gp_id = 5191480 THEN 'STAT_BUNDESAMT'
WHEN gp_id = 3098740 THEN 'IRI'
WHEN gp_id = 1922320 THEN 'GFK'
WHEN gp_id = 4625810 THEN 'NPD'
WHEN gp_id = 3126380 AND v1.mandant_id = 1 THEN 'NIELSEN_DE'
WHEN gp_id = 3126380 AND v1.mandant_id > 1 THEN 'NIELSEN_KMO'
WHEN gp_id = 10022115 THEN 'MARKETVECTOR'
END AS GP_EXP_NAME
,v1.wup_id
,v2.wup_standort
FROM dbp_msi_v_view.v_ais_mandant_wup v1
INNER JOIN dbp_view.v_wup v2
ON v1.mandant_id = v2.mandant_id
AND v1.wup_id = v2.wup_id
WHERE v1.gp_id <> -1
GROUP BY 1,2,3,4

UNION ALL

SELECT
v1.mandant_id
,CASE 
WHEN gp_id = 3126380 AND v1.mandant_id > 1 THEN 'NIELSEN_KMO_NEU'
END AS GP_EXP_NAME
,v1.wup_id
,v2.wup_standort
FROM dbp_msi_v_view.v_ais_mandant_wup v1
INNER JOIN dbp_view.v_wup v2
ON v1.mandant_id = v2.mandant_id
AND v1.wup_id = v2.wup_id
WHERE gp_id = 3126380 AND v1.mandant_id > 1
GROUP BY 1,2,3,4

UNION ALL

SELECT
v1.mandant_id
,'PRESSEGROSSISTEN' AS GP_EXP_NAME
,v1.wup_id
,v1.wup_standort
FROM dbp_view.v_wup v1
WHERE v1.mandant_id = 1
AND v1.nb_id = 0
AND v1.dat_von IS NOT NULL AND v1.dat_von < CURRENT_DATE
AND v1.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4;