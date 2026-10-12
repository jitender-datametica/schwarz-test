CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_aad_request_workflow_2 (
aad_request_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Request (Sequence)'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
dwh_created_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp when this record (version) of the Request was created. '),
creation_reason_comment_txt STRING(255)
OPTIONS(description='Describes the justification entered by the applicant - why the request was created'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
creator_user_id STRING(255) OPTIONS(description='AD name of the user who created the request'),
request_type_id INTEGER OPTIONS(description='specifies the type of request, 1=Period extension,  2 =Decryption'),
hashed_cashier_id STRING(255) OPTIONS(description='Encrypted (hashed) Cashier ID'),
request_status_type_id INTEGER
OPTIONS(description='Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected'),
fraud_value_gross_local_val NUMERIC(18,4)
OPTIONS(description='Specifies the fraud value in local currency,only from Receipts from scenario hits'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
expiration_tmsp DATETIME OPTIONS(description='Timestmap when at which point request expires and is no logner valid'),
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_hit_receipts_cnt INTEGER OPTIONS(description='Counts the number of receipts that are in scenario hit table'),
request_reason_type_id INTEGER OPTIONS(description='Identifier of the the reason code'),
comment_txt STRING(255) OPTIONS(description='Comment from editor of the request (approver, decrypter ..)'),
first_approver_user_id STRING(255) OPTIONS(description='AD name of the user  who approves the request first'),
second_approver_user_id STRING(255) OPTIONS(description='AD name of the user  who approves the request second'),
approve_by_council_fg INTEGER OPTIONS(description='Describes whether the release has been approved by council'),
criminal_complain_fg INTEGER OPTIONS(description='Describes whether a criminal complaint is filed'),
taken_measure_comment_txt STRING(255) OPTIONS(description='comment for the measure that have been taken for this case'),
loss_amount_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of loss in local currency'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (aad_request_id, dwh_created_tmsp) NOT ENFORCED
)
OPTIONS(description='AAD users see encrypted cashier IDs in the FE. When a scenario hit needs to be investigated in more details a FE user can request a decryption of the cashier ID so they can indetify the person involved in the possible fraud.\n             The workflow process through which these request go is tracked in this table (creation, approval, rejection, request for time extension  .. )');