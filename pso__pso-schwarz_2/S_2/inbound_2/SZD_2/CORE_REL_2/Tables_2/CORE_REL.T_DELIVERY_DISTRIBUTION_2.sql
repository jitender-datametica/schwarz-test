/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION_2
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 14:10:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_DISTRIBUTION_2 (
   DISTRIBUTION_NR                     VARCHAR(250)    NOT NULL COMMENT 'The business number of the distribution.',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The timestamp when the information was created or last updated',
   ACTIVITY_STATE_ID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique id of the activity state.',
   MAINTENANCE_STATE_ID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique id of the maintenance state.',
   DELIVERY_DISTRIBUTION_TYPE_CD       VARCHAR(50)     NOT NULL COMMENT 'The unique code of the delivery distribution type code.',
   PURCHASING_GROUP_NR                 VARCHAR(250)    COMMENT 'Descriptive Attribute - The business identifier of the purchasing group.',
   DISTRIBUTION_DESCR                  VARCHAR(250)    COMMENT 'Descriptive Attribute - A brief description text of the distribution.',
   DECOMMISSIONING_MONTH               NUMBER(38, 0)   COMMENT 'Descriptive Attribute - The month of decommisioning in the format of YYMM (e.g. 1707 for July 2017).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_DELIVERY_DISTRIBUTION PRIMARY KEY (DISTRIBUTION_NR, EVENT_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Containts information of a distribution of goods from a warehouse or supplier_2 to one or more stores. - Source - Lexis';
