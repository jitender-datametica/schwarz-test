CREATE OR REPLACE TABLE szd_production_core.t_fact_hga_maintenance_1 (
hga_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
report_dt DATE NOT NULL OPTIONS(description='The date on which the report is generated'),
cleaning_liquid_ltr_qty NUMERIC(29,5) OPTIONS(description='The measure of cleaning liquid solution in litre'),
service_cnt INTEGER NOT NULL OPTIONS(description='The counter of services happened on the machine for a report date'),
filter_cnt INTEGER NOT NULL OPTIONS(description='The counter of filter on the machine for a report date'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
cleaning_cnt INTEGER NOT NULL OPTIONS(description='The counter of cleaning done on machine for a report date'),
door_open_cnt INTEGER NOT NULL
OPTIONS(description='The number of times the door has been opened on a report date (derived from the error table based on the error type and status_1)'),
PRIMARY KEY (hga_sid, report_dt) NOT ENFORCED
)
OPTIONS(description='Periodic snapshot_1 fact table storing the measures such as the maintanence and cleaning operation counters of the machine as of the reported date');