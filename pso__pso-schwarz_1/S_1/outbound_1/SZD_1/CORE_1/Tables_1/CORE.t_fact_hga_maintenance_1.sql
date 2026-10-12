/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_maintenance_1
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:43:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_hga_maintenance_1 (
hga_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
report_dt DATE NOT NULL OPTIONS(description='The date on which the report is generated'),
cleaning_liquid_ltr_qty BIGNUMERIC(38,5) OPTIONS(description='The measure of cleaning liquid solution in litre'),
service_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The counter of services happened on the machine for a report date'),
filter_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The counter of filter on the machine for a report date'),
cleaning_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The counter of cleaning done on machine for a report date'),
door_open_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number of times the door has been opened on a report date (derived from the error table based on the error type and status_1)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, report_dt) NOT ENFORCED
)
OPTIONS(description='Periodic snapshot_1 fact table storing the measures such as the maintanence and cleaning operation counters of the machine as of the reported date');