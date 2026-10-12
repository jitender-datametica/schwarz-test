/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION_POSITION_2
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 14:02:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_distribution_position_2 (
distribution_nr STRING(250) NOT NULL OPTIONS(description='The business number of the distribution.'),
distribution_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the position of the delivery.'),
event_dt DATE NOT NULL OPTIONS(description='The timestamp when the information was created or last updated'),
supplier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the company.'),
activity_state_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique id of the activity state.'),
maintenance_state_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique id of the maintenance state.'),
cancelation_fg BOOL NOT NULL OPTIONS(description='A flag indicating that this distribution position was cancelled.'),
plan_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The planned quantity of the distribution position.'),
distribution_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The id identifying the distribution unit_2 of measure.'),
base_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Descriptive attribute - The id identifying the base unit_2 of measure.'),
sales_start_dt DATE OPTIONS(description='The date of the start of sale in the store.'),
promotion_dt DATE OPTIONS(description='The date of promotion.'),
eta_dt DATE OPTIONS(description='The estimated date of arrival.'),
origin_dispoweek_dt DATE OPTIONS(description='The date of the origin dispo week.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (distribution_position_nr, event_dt, distribution_nr) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Containts information of a position within the distribution of goods from a warehouse or supplier_2 to one or more stores. - Source - Lexis');