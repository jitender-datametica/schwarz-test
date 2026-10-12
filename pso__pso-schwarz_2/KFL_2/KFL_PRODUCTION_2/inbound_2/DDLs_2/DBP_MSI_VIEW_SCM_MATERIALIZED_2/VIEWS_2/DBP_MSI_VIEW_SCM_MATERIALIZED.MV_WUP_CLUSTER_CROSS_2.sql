create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WUP_CLUSTER_CROSS_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WUP_CLUSTER_ID,
	WUP_CLUSTER_CROSS_FG
) as
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v02.wup_cluster_id
,CASE WHEN v03.wup_cluster_id IS NULL THEN 0 ELSE 1 END AS wup_cluster_cross_fg
FROM DBP_VIEW.v_wup_2 v01
CROSS JOIN DBP_VIEW.v_ts_scm_l_wup_cluster_2 v02

LEFT JOIN DBP_VIEW.v_ts_scm_wup_cluster_zu_2 v03
  ON v01.mandant_id = v03.mandant_id
 AND v01.wup_id     = v03.wup_id
 AND v01.nb_id      = v03.nb_id
 AND v02.wup_cluster_id = v03.wup_cluster_id;