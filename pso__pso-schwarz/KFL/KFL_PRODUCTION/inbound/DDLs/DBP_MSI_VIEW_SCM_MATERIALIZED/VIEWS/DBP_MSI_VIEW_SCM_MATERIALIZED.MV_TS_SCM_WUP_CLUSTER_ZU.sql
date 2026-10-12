create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_SCM_WUP_CLUSTER_ZU(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WUP_CLUSTER_ID,
	WUP_CLUSTER_ZU_FG
) as
SELECT 
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,COALESCE(v03.wup_cluster_id, -99) AS wup_cluster_id
,CASE WHEN v03.wup_cluster_id IS NULL THEN 0 ELSE 1 END AS wup_cluster_zu_fg
FROM dbp_view.v_wup v01
LEFT JOIN dbp_view.v_ts_scm_wup_cluster_zu v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.wup_id = v02.wup_id
 AND v01.nb_id  = v02.nb_id
LEFT JOIN dbp_view.v_ts_scm_l_wup_cluster v03
  ON v03.mandant_id = v02.mandant_id
 AND v03.wup_cluster_id = v02.wup_cluster_id
 AND COALESCE(v03.wup_cluster_del_fg,0) = 0;