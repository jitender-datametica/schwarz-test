/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMER_APPLICATION_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:38:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMER_APPLICATION_1 (
   CHANNEL_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the channel.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CUSTOMER_APPLICATION_NR             VARCHAR(250)    NOT NULL COMMENT 'The unique business identifier of the customer application.',
   LABEL_NR                            VARCHAR(250)    COMMENT 'Descriptive Attribute - A unique label of the customer application.',
   EMAID_NR                            VARCHAR(250)    COMMENT 'Descriptive Attribute - The EMAID (e-Mobility Account_1 Identifier) code of the customer application.',
   CUSTOMER_UUID_NR                    VARCHAR(250)    COMMENT 'Unique customer identifier.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMER_APPLICATION PRIMARY KEY (CHANNEL_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A customer application is a piece of software on the smartphone of a customer used for increasing the customer loyallity by providing discounts on different products and services.- Source IOTCharger';
