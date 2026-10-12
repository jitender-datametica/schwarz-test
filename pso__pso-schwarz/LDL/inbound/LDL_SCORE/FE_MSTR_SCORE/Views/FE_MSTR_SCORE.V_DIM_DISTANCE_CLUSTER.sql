/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_distance_cluster
Description		| Grouping a set of distances in the same group
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_distance_cluster(
	distance_cluster_cd COMMENT 'This is a Code for a group a set of distances in the same group (called a cluster).',
	distance_cluster_name COMMENT 'Name of Distance Cluster',
	distance_cluster_from_km_meas COMMENT 'Lower bound of distance cluster  This value is included in interval.',
	distance_cluster_to_km_meas COMMENT 'Upper bound of distance cluster. This value is not included in interval.'
) COMMENT='This dimension is grouping a set of distances in the same group (called a cluster).'
 AS 
SELECT
   distance_cluster_cd
  ,distance_cluster_name
  ,distance_cluster_from_km_meas
  ,distance_cluster_to_km_meas
FROM core.t_dim_distance_cluster;