/* --------------------------------------------------------------------------------
   DDL for table: T_ROAMING_PRODUCT
   generated from Powerdesigner on Donnerstag, 16. November 2023 10:54:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ROAMING_PRODUCT (
   ROAMING_PRODUCT_ID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the roaming product.',
   ROAMING_INTERFACE_CD                VARCHAR(50)     NOT NULL COMMENT 'The unique code of the roaming interface.',
   ROAMING_PRODUCT_NAME                VARCHAR(100)    NOT NULL COMMENT 'Natural/Business Key - The unique name of the roaming product.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_ROAMING_PRODUCT PRIMARY KEY (ROAMING_PRODUCT_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The roaming tariff used when roaming is active during a charging session. Roaming is active if the operator of the charge point is different from the seller of the power for charging the car. - Source IOTCharger';
