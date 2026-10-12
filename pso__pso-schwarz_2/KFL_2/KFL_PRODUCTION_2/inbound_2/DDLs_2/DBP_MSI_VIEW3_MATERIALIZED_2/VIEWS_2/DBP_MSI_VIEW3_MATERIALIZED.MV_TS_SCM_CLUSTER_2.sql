create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TS_SCM_CLUSTER_2(
	CLUSTER_TYP_ID,
	CLUSTER_TYP_BEZ,
	CLUSTER_ID,
	CLUSTER_BEZ,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ELEMENT_BEZ,
	ZEIT_VON,
	ZEIT_BIS,
	WERT_VON,
	WERT_BIS
) as
-- AP0150311_SPEC0174516, initial
SELECT 
cluster_typ_id,
cluster_typ_bez,
cluster_id,
cluster_bez,
cluster_element_id,
cluster_element_bez,
zeit_von,
zeit_bis,
wert_von,
wert_bis
FROM
dbp_msi_data.ts_scm_cluster_2;