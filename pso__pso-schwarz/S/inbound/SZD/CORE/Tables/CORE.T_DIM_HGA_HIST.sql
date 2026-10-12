/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_HIST
   generated from Powerdesigner on Dienstag, 25. März 2025 15:46:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HGA_HIST (
   HGA_SID                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   STORE_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a main store. It is identical to the key of the store that has first been assigned to this main store.',
   LOB_CD                              VARCHAR(50)     NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland 
            lob=line os business',
   MANUFACTURER_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
   HGA_VERSION_NR                      VARCHAR(250)             COMMENT 'The version for the Hot Beverage machine.',
   SERIAL_NR                           VARCHAR(250)    NOT NULL COMMENT 'The identifier for a hot beverage machine which is located in a store.',
   STORE_NR                            VARCHAR(250)    NOT NULL COMMENT 'The number by which the store is known to business. This number is unique for a given client_id, but not globally unique. (The same number can be in different clients).',
   STORE_NAME                          VARCHAR(100)    NOT NULL COMMENT 'The name, by which the store in known.',
   COUNTRY_POL_CD                      VARCHAR(3)      NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_DIM_HGA_HIST PRIMARY KEY (HGA_SID, DWH_VALID_FROM_DT) NOT ENFORCED 
)  COMMENT = 'The major dimension for hot beverage machines located in stores';
