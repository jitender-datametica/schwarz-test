/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_order
   generated from Powerdesigner on Mittwoch, 16. Oktober 2024 16:23:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organizatio (store or sales company/VGES)',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
   int_org_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the sales company (VGES) /Store to which this store is related.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   requestor_user_name                 VARCHAR(100)    NOT NULL COMMENT 'The MicroStrategy-User who requests fraud detection analysis for organization unit in ZKP-Solution',
   request_tmsp                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
   approver_user_name                  VARCHAR(100)    COMMENT 'The MicroStrategy-User who approves the fraud detection analysis for organization unit in ZKP-Solution',
   approved_tmsp                       TIMESTAMP_TZ(9) COMMENT 'The point in time when this record approved by the MicroStrategy-User.',
   analysis_period_start_dt            DATE            NOT NULL COMMENT 'The begin date of the period which receipts of the internal organization will be analysed',
   analysis_period_end_dt              DATE            NOT NULL COMMENT 'The end date of the period which receipts of the internal organization will be analysed',
   order_parameter_status_cd           VARCHAR(20)     NOT NULL COMMENT 'The status of a order parameter if it is approved, requested or denied.',
   order_reason_cd                     VARCHAR(20)     COMMENT 'The revision reason code for an analysis, if it is for threshold definition or fraud analysis',
   audit_user_name                     VARCHAR(100)    COMMENT 'The MicroStrategy-User who prooves and start the audit.',
   audit_tmsp                          TIMESTAMP_TZ(9) COMMENT 'The point in time when this record approved by the MicroStrategy-User or the audit got started from the MicroStrategy-User ',
   cancel_scenario_grp_fg              BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'An indicator showing the analysis should proove the cancel scenarios group.',
   deposit_scenario_grp_fg             BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'An indicator showing the analysis should proove the deposit scenarios group',
   return_scenario_grp_fg              BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'An indicator showing the analysis should proove the return scenario group',
   abort_scenario_grp_suspend_fg       BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'An indicator showing the analysis should proove the abourt/suspend scenario group',
   discount_scenario_grp_fg            BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'An indicator showing the analysis should proove the discount scenario group',
   other_scenario_grp_fg               BOOLEAN         DEFAULT TRUE NOT NULL COMMENT 'xxx An indicator showing the analysis should proove the other scenario group',
   test_fg                             BOOLEAN         DEFAULT FALSE NOT NULL COMMENT 'An indicator showing the analysis is a test case',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_ORDER PRIMARY KEY (int_org_sid, request_tmsp) NOT ENFORCED
 )  COMMENT= 'Contains the requestes for all fraud detection audits. Hold the status of the request, requester and approver. A request can be placed and it can be store or internal (sales / VGES) company. The request is for a certain period, this is by default for the sales company the last 8 full weeks.A request can be placed for one or several group of scenarios. Additional a business (audit user) start the audit proces.';
