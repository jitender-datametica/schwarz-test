CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_L_MARKT_CLUSTER(
	MANDANT_ID,
	INIT_LIEF_MARKT_CLUSTER_ID
) AS
--2024-02-15, AP0187197, SPEC0234136, initial, dknop
SELECT 
 mandant_id
,init_lief_markt_cluster_id
FROM dbp_data.wbs_l_markt_cluster_initiale_belieferung


;