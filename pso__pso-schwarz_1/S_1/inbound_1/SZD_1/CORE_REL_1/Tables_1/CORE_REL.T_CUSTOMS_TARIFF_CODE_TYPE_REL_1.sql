/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_TARIFF_CODE_TYPE_REL_1
   generated from Powerdesigner on Montag, 31. Juli 2023 11:10:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_TARIFF_CODE_TYPE_REL_1 (
   CUSTOMS_CLASSIFICATION_SCHEME_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs classification scheme.',
   CUSTOMS_TARIFF_CODE_CD              VARCHAR(250)    NOT NULL COMMENT 'The standardized customs tariff code number.',
   CUSTOMS_TARIFF_CODE_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs tariff code type.',
   CUSTOMS_TARIFF_CATEGORY_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs tariff category.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_TARIFF_CODE_TYPE_REL PRIMARY KEY (CUSTOMS_CLASSIFICATION_SCHEME_CD, CUSTOMS_TARIFF_CODE_CD, CUSTOMS_TARIFF_CODE_TYPE_CD, CUSTOMS_TARIFF_CATEGORY_CD) NOT ENFORCED 
)  COMMENT = 'Bridge Table - Contains the associations between customs tariff codes and their types. - Source - Manual';
