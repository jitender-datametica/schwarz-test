/* --------------------------------------------------------------------------------
   DDL for table: t_mapping_rule_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_MAPPING_RULE_1 (
   map_grp_name                        VARCHAR(100)    NOT NULL COMMENT 'The name which describes the purpose of the mapping group.',
   map_name                            VARCHAR(100)    NOT NULL COMMENT 'The name for the mapping, i.e. for the set of rules and algorithms which specify, how one or several source data structures are transformed into a target data structure. (Typically, there is one mapping for each target table.)',
   block_nr                            NUMBER(38, 0)   NOT NULL COMMENT 'The identifier of the mapping block within a mapping',
   tgt_data_obj_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the target data object.',
   src_data_obj_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the source data object.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   transform_cd                        VARCHAR(20)     COMMENT 'A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.',
   transform_param_txt                 VARCHAR(1000)   COMMENT 'A transformation may use a parameter, e.g. a factor for a calculation or a join condition.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_MAPPING_RULE PRIMARY KEY (map_grp_name, map_name, block_nr, src_data_obj_sid, tgt_data_obj_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A mapping rule defines how a specific target data object is derived. A mapping rule belongs to a block in a mapping. Mapping Rules can be defined on the level of data structures (a.k.a. block level transformations) or for data elements. A target data object may depend on one or on several input data objects.';
