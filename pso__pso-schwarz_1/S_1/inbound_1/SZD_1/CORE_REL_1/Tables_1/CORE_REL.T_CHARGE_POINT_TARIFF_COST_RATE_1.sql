/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_TARIFF_COST_RATE_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 11:09:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_TARIFF_COST_RATE_1 (
   CHARGE_POINT_COST_RATE_ID           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the charge point tariff.',
   CHARGE_POINT_TARIFF_ID              NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the charge point tariff.',
   CHARGE_POINT_COST_RATE_NR           VARCHAR(250)    NOT NULL COMMENT 'The code of the cost rate for the charge point tariff.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_TARIFF_COST_RATE PRIMARY KEY (CHARGE_POINT_COST_RATE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the possible cost rates of a charge point tariff. - Source - IOTCharger';
