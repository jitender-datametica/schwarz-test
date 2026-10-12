/* --------------------------------------------------------------------------------
   DDL for table: T_AGREEMENT_KEY
   generated from Powerdesigner on Montag, 27. November 2023 10:12:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_AGREEMENT_KEY (
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the agreement.',
   AGREEMENT_KEY_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the agreement.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   AGREEMENT_NAT_KEY_NR                VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the agreement.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_AGREEMENT_KEY PRIMARY KEY (AGREEMENT_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, AGREEMENT_NAT_KEY_NR) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Agreement - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Agreement ".';