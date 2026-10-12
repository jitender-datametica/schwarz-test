create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_SCM_ART_CLUSTER_ZU_2(
	MANDANT_ID,
	ART_ID,
	ART_CLUSTER_ID,
	ART_CLUSTER_ZU_FG
) as
SELECT 
 v01.mandant_id
,v01.art_id
,COALESCE(v03.art_cluster_id, -99) AS art_cluster_id
,CASE WHEN v03.art_cluster_id IS NULL THEN 0 ELSE 1 END AS art_cluster_zu_fg
FROM dbp_view.v_art_2 v01
LEFT JOIN dbp_view.v_ts_scm_art_cluster_zu_2 v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.art_id     = v02.art_id
LEFT JOIN dbp_view.v_ts_scm_l_art_cluster_2 v03
  ON v03.mandant_id = v02.mandant_id
 AND v03.art_cluster_id = v02.art_cluster_id
 AND COALESCE(v03.art_cluster_del_fg,0) = 0;