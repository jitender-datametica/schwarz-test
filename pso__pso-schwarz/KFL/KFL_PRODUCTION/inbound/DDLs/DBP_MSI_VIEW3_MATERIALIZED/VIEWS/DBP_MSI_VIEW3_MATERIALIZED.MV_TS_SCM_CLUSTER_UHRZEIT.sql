create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TS_SCM_CLUSTER_UHRZEIT(
	CLUSTER_ID,
	CLUSTER_BEZ,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ELEMENT_BEZ
) as
--2022-12-05, AP0150311_SPEC0174516, dknop, initial
    SELECT 
 DISTINCT cluster_id
,cluster_bez
,CASE WHEN cluster_id = 4 AND cluster_element_id = 4 THEN 3 ELSE cluster_element_id END AS cluster_element_id
,CASE WHEN cluster_id = 4 AND cluster_element_id IN (3,4) THEN 'Nacht' ELSE cluster_element_bez END AS cluster_element_bez

FROM dbp_msi_data.ts_scm_cluster
WHERE cluster_typ_bez LIKE '%Uhrzeit%';