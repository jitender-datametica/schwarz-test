CREATE TABLE CORE.t_dim_weight_classification_1 (
   weight_class_cd                     VARCHAR(50)      NOT NULL COMMENT 'A code for weight classification',
   weight_class_descr                  VARCHAR(250)     NULL COMMENT 'A description for weightclassification',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_weight_classification PRIMARY KEY (weight_class_cd)
)COMMENT = 'This minor dimension defines  the cluster by which the product weight is classified .Groups the shipments by weight in 1 kilogram steps. The cluster starts with 0-1. And "above 50" is the max cluster.Unit_1: kilogram';