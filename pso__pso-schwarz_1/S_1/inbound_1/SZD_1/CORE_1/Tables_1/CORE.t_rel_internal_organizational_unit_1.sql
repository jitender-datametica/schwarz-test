CREATE TABLE CORE.t_rel_internal_organizational_unit_1 (
   int_org_unit_id      NUMBER     NOT NULL COMMENT 'The identifier of the organozational unit_1',
   int_org_unit_name    VARCHAR(1000) NOT NULL COMMENT 'The textual name of the organozational unit_1',
   int_org_unit_child_id NUMBER    NOT NULL COMMENT 'The identifier of the child organozational unit_1',
   int_org_unit_child_name VARCHAR(1000) NOT NULL COMMENT 'The textual name of the child organozational unit_1',
   int_org_unit_relation_type VARCHAR(250) NOT NULL COMMENT 'The relationship type between parent and child org units',
   dwh_created_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT pk_t_dim_internal_organizational_unit PRIMARY KEY (int_org_unit_id,int_org_unit_child_id,int_org_unit_relation_type)
   ) COMMENT = 'The relational table describes the relationship type between org units ';