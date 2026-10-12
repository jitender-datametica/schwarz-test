/* --------------------------------------------------------------------------------
   DDL for table: t_dim_benchmarking_type
   generated from Powerdesigner on Montag, 5. Februar 2024 16:03:36
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_BENCHMARKING_TYPE (
   benchmarking_type_id                NUMBER(38, 0)   NOT NULL COMMENT 'The benchmarking type identifies the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc.',
   benchmarking_type_descr             VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc. (Description in group language, i.e. in German)',
   benchmarking_type_descr_de          VARCHAR(250)    COMMENT 'A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc. (Description in German)',
   benchmarking_type_descr_en          VARCHAR(250)    COMMENT 'A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_BENCHMARKING_TYPE PRIMARY KEY (benchmarking_type_id) NOT ENFORCED
 )  COMMENT= 'The benchmarking type identifies the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy levels of e.g. the organizational unit hierarchy, like - all countries for viewing all records (international view), by country, by company (VGES/BGES), by sales manager, etc.';
