/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_TARIFF_CATEGORY
   generated from Powerdesigner on Montag, 31. Juli 2023 10:46:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_TARIFF_CATEGORY (
   CUSTOMS_TARIFF_CATEGORY_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs tariff category.',
   CUSTOMS_TARIFF_CATEGORY_DESCR       VARCHAR(250)    NOT NULL COMMENT 'A brief description of the customs tariff category.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_TARIFF_CATEGORY PRIMARY KEY (CUSTOMS_TARIFF_CATEGORY_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - A customs tariff number can be associated to different categories that are not mutualy exclusive. These categories are defined in this table. - Source - Manual';