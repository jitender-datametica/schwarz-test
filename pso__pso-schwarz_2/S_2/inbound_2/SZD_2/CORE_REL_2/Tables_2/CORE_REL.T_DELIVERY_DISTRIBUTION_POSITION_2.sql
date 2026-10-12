/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION_POSITION_2
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 14:02:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_DISTRIBUTION_POSITION_2 (
   DISTRIBUTION_NR                     VARCHAR(250)    NOT NULL COMMENT 'The business number of the distribution.',
   DISTRIBUTION_POSITION_NR            NUMBER(38, 0)   NOT NULL COMMENT 'The number of the position of the delivery.',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The timestamp when the information was created or last updated',
   SUPPLIER_PARTY_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the company.',
   ACTIVITY_STATE_ID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique id of the activity state.',
   MAINTENANCE_STATE_ID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique id of the maintenance state.',
   CANCELATION_FG                      BOOLEAN         NOT NULL COMMENT 'A flag indicating that this distribution position was cancelled.',
   PLAN_QTY                            NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The planned quantity of the distribution position.',
   DISTRIBUTION_UNIT_ID                NUMBER(38, 0)   NOT NULL COMMENT 'The id identifying the distribution unit_2 of measure.',
   BASE_UNIT_ID                        NUMBER(38, 0)   NOT NULL COMMENT 'Descriptive attribute - The id identifying the base unit_2 of measure.',
   SALES_START_DT                      DATE            COMMENT 'The date of the start of sale in the store.',
   PROMOTION_DT                        DATE            COMMENT 'The date of promotion.',
   ETA_DT                              DATE            COMMENT 'The estimated date of arrival.',
   ORIGIN_DISPOWEEK_DT                 DATE            COMMENT 'The date of the origin dispo week.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DELIVERY_DISTRIBUTION_POSITION PRIMARY KEY (DISTRIBUTION_POSITION_NR, EVENT_DT, DISTRIBUTION_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Containts information of a position within the distribution of goods from a warehouse or supplier_2 to one or more stores. - Source - Lexis';
