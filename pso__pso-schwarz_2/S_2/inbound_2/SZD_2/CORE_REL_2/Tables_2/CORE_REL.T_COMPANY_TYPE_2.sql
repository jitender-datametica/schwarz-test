/* --------------------------------------------------------------------------------
   DDL for table: T_COMPANY_TYPE_2
   generated from Powerdesigner on Freitag, 13. Oktober 2023 12:23:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COMPANY_TYPE_2 (
   COMPANY_TYPE_CD                     VARCHAR(50)     NOT NULL COMMENT 'The code for the type of the company company (Supplier_2 ,  Hauler,  Handling agents , etc) to which t_company_2 references on.',
   COMPANY_TYPE_DESCR                  VARCHAR(250)    COMMENT 'A textual description for the company_type_cd written out in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_COMPANY_TYPE PRIMARY KEY (COMPANY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The minor dimension that contain site type for an selected company (Supplier_2 ,  Hauler,  Handling agents , etc) - Source - Manual';
