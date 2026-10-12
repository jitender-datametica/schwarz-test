CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ANZ_TAGE_CLUSTER_1(
	ANZ_TAGE_AKTION,
	CLUSTER_DAUER_ID,
	CLUSTER_DAUER_DESC
) AS
--2025-08-25, dknop, AP0269651, SPEC0329583, initial
 SELECT DISTINCT 
 a_w.anz_tage_aktion
,a_w.cluster_dauer_id
,c_desc.cluster_dauer_desc
FROM dbp_data.avq_werbung_1 a_w
JOIN dbp_msi_view_scm.mv_cluster_dauer_spr_zu_1 c_desc
ON a_w.cluster_dauer_id = c_desc.cluster_dauer_id;