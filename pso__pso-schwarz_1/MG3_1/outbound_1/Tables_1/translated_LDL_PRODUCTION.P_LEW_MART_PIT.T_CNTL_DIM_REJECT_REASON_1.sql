CREATE OR REPLACE TABLE ldl_production_p_lew_mart_pit.t_cntl_dim_reject_reason_1 (
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique Identifier of Reject Reason'),
reject_reason_descr STRING(1500) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Reject Reason Annotation further description'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field: Version Number of record')
);