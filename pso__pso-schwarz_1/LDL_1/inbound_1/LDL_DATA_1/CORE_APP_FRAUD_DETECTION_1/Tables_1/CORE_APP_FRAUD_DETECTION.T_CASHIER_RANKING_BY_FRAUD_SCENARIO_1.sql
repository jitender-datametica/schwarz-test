/* --------------------------------------------------------------------------------
   DDL for table: t_cashier_ranking_by_fraud_scenario_1
   generated from Powerdesigner on Montag, 10. Februar 2025 16:45:05
*/ --------------------------------------------------------------------------------
 
CREATE TABLE CORE_APP_FRAUD_DETECTION.T_CASHIER_RANKING_BY_FRAUD_SCENARIO_1 (
   sales_company_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the sales_1 company (VGES) to which this store is related.',
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
   cashier_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
   scenario_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
   rank_seq                            NUMERIC(38,0)   NOT NULL COMMENT 'This column will contain a rank number (or be left blank if not ranked in the top) indicating whether a cashier is within the top X (depending on the thresholds) based on the number of suspicious receipts.',
   relevant_for_manual_report_fg       BOOLEAN         NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CASHIER_RANKING_BY_FRAUD_SCENARIO PRIMARY KEY (store_sid, cashier_nr, scenario_id) NOT ENFORCED
)  COMMENT= 'Ranks the cashier for a given audit period per scenario per sales_company level';