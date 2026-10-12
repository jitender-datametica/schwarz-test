CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TS_SCM_CLUSTER_DAUER(
	CLUSTER_ID,
	CLUSTER_BEZ,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ELEMENT_BEZ
) AS
--2022-11-15, AP0150311_SPEC0174516, dknop, initial
SELECT 
 cluster_id
,cluster_bez
,cluster_element_id
,cluster_element_bez

FROM dbp_msi_data.ts_scm_cluster
WHERE cluster_typ_bez LIKE '%Dauer%';