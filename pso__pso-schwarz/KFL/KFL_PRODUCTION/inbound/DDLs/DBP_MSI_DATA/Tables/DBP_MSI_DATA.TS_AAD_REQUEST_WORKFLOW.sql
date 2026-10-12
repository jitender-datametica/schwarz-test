--==============================================================
-- Table: ts_aad_request_workflow
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_aad_request_workflow
   generated from Powerdesigner on Montag, 5. Juni 2023 07:04:44
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW (
   aad_request_id                      NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Request (Sequence)',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when this record (version) of the Request was created. ',
   creation_reason_comment_txt         VARCHAR(255)     COMMENT 'Describes the justification entered by the applicant - why the request was created',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   creator_user_id                     VARCHAR(255)     COMMENT 'AD name of the user who created the request',
   request_type_id                     NUMBER(38,0)     COMMENT 'specifies the type of request, 1=Period extension,  2 =Decryption',
   hashed_cashier_id                   VARCHAR(255)     COMMENT 'Encrypted (hashed) Cashier ID',
   request_status_type_id              NUMBER(38,0)     COMMENT 'Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected',
   fraud_value_gross_local_val         NUMBER(18,4)     COMMENT 'Specifies the fraud value in local currency,only from Receipts from scenario hits',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   expiration_tmsp                     TIMESTAMP_NTZ(9) COMMENT 'Timestmap when at which point request expires and is no logner valid',
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_hit_receipts_cnt           NUMBER(38,0)     COMMENT 'Counts the number of receipts that are in scenario hit table',
   request_reason_type_id              NUMBER(38,0)     COMMENT 'Identifier of the the reason code',
   comment_txt                         VARCHAR(255)     COMMENT 'Comment from editor of the request (approver, decrypter ..)',
   first_approver_user_id              VARCHAR(255)     COMMENT 'AD name of the user  who approves the request first',
   second_approver_user_id             VARCHAR(255)     COMMENT 'AD name of the user  who approves the request second',
   approve_by_council_fg               NUMBER(38,0)     COMMENT 'Describes whether the release has been approved by council',
   criminal_complain_fg                NUMBER(38,0)     COMMENT 'Describes whether a criminal complaint is filed',
   taken_measure_comment_txt           VARCHAR(255)     COMMENT 'comment for the measure that have been taken for this case',
   loss_amount_gross_local_val         NUMBER(18,4)     COMMENT 'Amount of loss in local currency',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AAD_REQUEST_WORKFLOW PRIMARY KEY (aad_request_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'AAD users see encrypted cashier IDs in the FE. When a scenario hit needs to be investigated in more details a FE user can request a decryption of the cashier ID so they can indetify the person involved in the possible fraud.
             The workflow process through which these request go is tracked in this table (creation, approval, rejection, request for time extension  .. )';
