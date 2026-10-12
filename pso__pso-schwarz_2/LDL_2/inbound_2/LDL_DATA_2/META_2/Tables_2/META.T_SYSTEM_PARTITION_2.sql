/* --------------------------------------------------------------------------------
   DDL for table: t_system_partition_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_SYSTEM_PARTITION_2 (
   sys_partition_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code which uniquely identifies the part or the instance of an IT system.',
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system to which the partition belongs.',
   sys_partition_name                  VARCHAR(100)    NOT NULL COMMENT 'The name for the part or the instance of an IT system. E.g. Wawi Germany.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SYSTEM_PARTITION PRIMARY KEY (sys_partition_cd) NOT ENFORCED
 )  COMMENT= 'A part or an instance of an IT system, which runs independently.E.g. a Wawi instance.';