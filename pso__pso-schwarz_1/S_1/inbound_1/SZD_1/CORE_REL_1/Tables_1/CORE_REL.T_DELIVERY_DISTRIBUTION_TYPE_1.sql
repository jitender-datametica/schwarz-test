/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION_TYPE_1
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 13:53:53
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_DISTRIBUTION_TYPE_1 (
   DELIVERY_DISTRIBUTION_TYPE_CD       VARCHAR(50)     NOT NULL COMMENT 'The unique code of the delivery distribution type code.',
   DELIVERY_DISTRIBUTION_TYPE_NAME     VARCHAR(100)    NOT NULL COMMENT 'The name of the delivery distribution type code.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_DELIVERY_DISTRIBUTION_TYPE PRIMARY KEY (DELIVERY_DISTRIBUTION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Contains the possible types a delivery distributions can have. - Source - Manual.';
