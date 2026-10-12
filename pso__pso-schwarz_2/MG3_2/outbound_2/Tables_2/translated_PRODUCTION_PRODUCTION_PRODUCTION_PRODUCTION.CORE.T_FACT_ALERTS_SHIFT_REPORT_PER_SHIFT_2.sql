CREATE OR REPLACE TABLE production_production_core.t_fact_alerts_shift_report_per_shift_2 (
alerts_day_shift_id INTEGER NOT NULL OPTIONS(description='The unique identifier for a specific shift.'),
alerts_shift_report_agreement_txt STRING(16777216)
OPTIONS(description='A textual field for input our of the MSTR transaction service regarding agreements in a specific shift.'),
alerts_shift_report_next_shift_txt STRING(16777216)
OPTIONS(description='A textual field for input our of the MSTR transaction service regarding topics for the next shift.'),
alerts_shift_report_out_of_order_txt STRING(16777216)
OPTIONS(description='A textual field for input our of the MSTR transaction service regarding production unit_2 components which are out of order in a specific shift.'),
alerts_shift_report_security_issues STRING(16777216)
OPTIONS(description='The unique identifier for the alarm priorities (also containing inactive components)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='Fact table which captures the transactional input from Microstrategy frontend regarind the shift reports per shift.');