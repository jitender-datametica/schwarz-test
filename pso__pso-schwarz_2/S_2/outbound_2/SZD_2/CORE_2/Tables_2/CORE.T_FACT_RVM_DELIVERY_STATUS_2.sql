CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_delivery_status_2 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
rvm_processing_dt DATE NOT NULL OPTIONS(description='The date when the reports are processed'),
rvm_report_dt DATE NOT NULL OPTIONS(description='The date of the source report file'),
rvm_last_send_dt DATE OPTIONS(description='The last sent date captured from the deposit receipt'),
rvm_delivery_status STRING(250) NOT NULL
OPTIONS(description='The delivery status_2 of the deposit machine (e.g.ok,Nachlieferung,Neue Lieferung.. )'),
diff_in_days_cnt BIGNUMERIC(38,0)
OPTIONS(description='The date interval between the last send date and the processing date'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
PRIMARY KEY (rvm_sid, rvm_processing_dt, rvm_report_dt) NOT ENFORCED
) OPTIONS(description='Snapshot_2 fact capturing the delivery status_2 of deposit machines');