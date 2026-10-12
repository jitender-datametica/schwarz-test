/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_distance_cluster_2
Description		| Grouping a set of distances in the same group
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_distance_cluster_2 (distance_cluster_cd
OPTIONS(description='This is a Code for a group a set of distances in the same group (called a cluster).'),
distance_cluster_name OPTIONS(description='Name of Distance Cluster'), distance_cluster_from_km_meas
OPTIONS(description='Lower bound of distance cluster  This value is included in interval.'), distance_cluster_to_km_meas
OPTIONS(description='Upper bound of distance cluster. This value is not included in interval.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION IS GROUPING A SET OF DISTANCES IN THE SAME GROUP (CALLED A CLUSTER).`) AS SELECT
 distance_cluster_cd,
 distance_cluster_name,
 distance_cluster_from_km_meas,
 distance_cluster_to_km_meas
FROM ldl_score_core.t_dim_distance_cluster_2;