CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_SCM_WUP_CLUSTER_ZU_1
( mandant_id
,wup_id
,nb_id
,wup_cluster_id
,wup_cluster_zu_fg)-- 2025-07-16 | nwag | switch to dt
AS
SELECT 
 mandant_id
,wup_id
,nb_id
,wup_cluster_id
,wup_cluster_zu_fg
FROM DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_WUP_CLUSTER_ZU_1;
