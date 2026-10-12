/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_TARIFF_2
   generated from Powerdesigner on Mittwoch, 15. November 2023 13:06:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_TARIFF_2 (
   CHARGE_POINT_TARIFF_ID              NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the charge point tariff.',
   CHARGE_POINT_TARIFF_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charge point tariff type.',
   CHARGE_POINT_TARIFF_NAME            VARCHAR(100)    NOT NULL COMMENT 'Natural/Business Key - The unique name of the charge point tariff.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_TARIFF PRIMARY KEY (CHARGE_POINT_TARIFF_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The tariff defines who is able to use the charge point and how much is to pay for the usage. - Source - IOTCharger';
