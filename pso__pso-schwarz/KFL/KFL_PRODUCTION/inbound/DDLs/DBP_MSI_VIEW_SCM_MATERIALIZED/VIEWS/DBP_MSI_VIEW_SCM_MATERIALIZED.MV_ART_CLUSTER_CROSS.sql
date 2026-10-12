create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_CLUSTER_CROSS(
	MANDANT_ID,
	ART_ID,
	ART_CLUSTER_ID,
	ART_CLUSTER_CROSS_FG
) as
SELECT
 v01.mandant_id
,v01.art_id
,v02.art_cluster_id
,CASE WHEN v03.art_cluster_id IS NULL THEN 0 ELSE 1 END AS art_cluster_cross_fg
FROM DBP_VIEW.v_art v01
CROSS JOIN DBP_VIEW.v_ts_scm_l_art_cluster v02

LEFT JOIN DBP_VIEW.v_ts_scm_art_cluster_zu v03
  ON v01.mandant_id     = v03.mandant_id
 AND v01.art_id         = v03.art_id
 AND v02.mandant_id     = v03.mandant_id
 AND v02.art_cluster_id = v03.art_cluster_id;