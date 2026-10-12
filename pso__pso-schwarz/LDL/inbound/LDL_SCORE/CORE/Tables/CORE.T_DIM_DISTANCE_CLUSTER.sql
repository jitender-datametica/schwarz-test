--==============================================================
-- Table: t_dim_distance_cluster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_distance_cluster
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DISTANCE_CLUSTER (
   distance_cluster_cd                 VARCHAR(20)      NOT NULL COMMENT 'This is a Code for a group a set of distances in the same group (called a cluster).',
   distance_cluster_name               VARCHAR(100)     COMMENT 'Name of Distance Cluster',
   distance_cluster_name_de            VARCHAR(100)     COMMENT 'Name of Distance Cluster in German',
   distance_cluster_name_en            VARCHAR(100)     COMMENT 'Name of Distance Cluster  in English',
   distance_cluster_from_km_meas       NUMBER(38, 5)    COMMENT 'Lower bound of distance cluster  This value is included in interval.',
   distance_cluster_to_km_meas         NUMBER(38, 5)    COMMENT 'Upper bound of distance cluster. This value is not included in interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_DISTANCE_CLUSTER PRIMARY KEY (distance_cluster_cd) NOT ENFORCED 
)  COMMENT = 'This dimension is grouping a set of distances in the same group (called a cluster).';

