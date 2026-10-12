CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_distance_cluster_2 (
distance_cluster_cd STRING(20) NOT NULL
OPTIONS(description='This is a Code for a group a set of distances in the same group (called a cluster).'),
distance_cluster_name STRING(100) OPTIONS(description='Name of Distance Cluster'),
distance_cluster_name_de STRING(100) OPTIONS(description='Name of Distance Cluster in German'),
distance_cluster_name_en STRING(100) OPTIONS(description='Name of Distance Cluster  in English'),
distance_cluster_from_km_meas BIGNUMERIC(38,5)
OPTIONS(description='Lower bound of distance cluster  This value is included in interval.'),
distance_cluster_to_km_meas BIGNUMERIC(38,5)
OPTIONS(description='Upper bound of distance cluster. This value is not included in interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (distance_cluster_cd) NOT ENFORCED
) OPTIONS(description='This dimension is grouping a set of distances in the same group (called a cluster).');