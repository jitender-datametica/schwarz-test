CREATE TABLE core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY (
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   int_org_hierarchy_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of hierarchy for internal organizations.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   parent_int_org_sid                  NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization, which is one level up in the hierarchy defined by the hierarchy type code.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTERNAL_ORGANIZATION_HIERARCHY PRIMARY KEY (int_org_hierarchy_type_cd, int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the hierarchy of internal organization units. It relates an internal organization to its parent organization one level up in the hierarchy. This entity can store multiple hierarchies. The kind of hierarchy is identified by the hierarchy type code.';
