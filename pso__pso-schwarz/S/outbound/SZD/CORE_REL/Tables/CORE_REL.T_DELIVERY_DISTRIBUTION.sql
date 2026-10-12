/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 14:10:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_distribution (
distribution_nr STRING(250) NOT NULL OPTIONS(description='The business number of the distribution.'),
event_dt DATE NOT NULL OPTIONS(description='The timestamp when the information was created or last updated'),
activity_state_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique id of the activity state.'),
maintenance_state_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique id of the maintenance state.'),
delivery_distribution_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the delivery distribution type code.'),
purchasing_group_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The business identifier of the purchasing group.'),
distribution_descr STRING(250)
OPTIONS(description='Descriptive Attribute - A brief description text of the distribution.'),
decommissioning_month BIGNUMERIC(38,0)
OPTIONS(description='Descriptive Attribute - The month of decommisioning in the format of YYMM (e.g. 1707 for July 2017).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (distribution_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Containts information of a distribution of goods from a warehouse or supplier to one or more stores. - Source - Lexis');