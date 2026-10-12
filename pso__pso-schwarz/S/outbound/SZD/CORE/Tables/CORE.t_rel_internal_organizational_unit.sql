CREATE TABLE IF NOT EXISTS szd_core.t_rel_internal_organizational_unit (
int_org_unit_id BIGNUMERIC NOT NULL OPTIONS(description='The identifier of the organozational unit'),
int_org_unit_name STRING(1000) NOT NULL OPTIONS(description='The textual name of the organozational unit'),
int_org_unit_child_id BIGNUMERIC NOT NULL OPTIONS(description='The identifier of the child organozational unit'),
int_org_unit_child_name STRING(1000) NOT NULL OPTIONS(description='The textual name of the child organozational unit'),
int_org_unit_relation_type STRING(250) NOT NULL
OPTIONS(description='The relationship type between parent and child org units'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (int_org_unit_id, int_org_unit_child_id, int_org_unit_relation_type) NOT ENFORCED
) OPTIONS(description='The relational table describes the relationship type between org units ');