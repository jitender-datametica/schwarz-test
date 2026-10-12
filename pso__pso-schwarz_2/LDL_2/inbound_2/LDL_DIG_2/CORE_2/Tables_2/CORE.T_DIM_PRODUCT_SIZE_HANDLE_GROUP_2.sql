/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SIZE_HANDLE_GROUP_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 27. Dezember 2023 14:25:03
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_SIZE_HANDLE_GROUP_2 (
   PROD_SIZE_HANDLE_GROUP_CD           VARCHAR(10)     NOT NULL COMMENT 'Product size classification defined by Controlling/PM. It divides the product size in types based on their dimensions (P_KT,P_GT,P_2MH, P_Sonst).
            Necessary for evaluation of variable and fixed costs based on the size group.',
   PROD_SIZE_HANDLE_GROUP_DESCR        VARCHAR(250)    COMMENT 'A textual description for the product size classification in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PRODUCT_SIZE_HANDLE_GROUP PRIMARY KEY (PROD_SIZE_HANDLE_GROUP_CD) NOT ENFORCED 
)  COMMENT = 'Minor dimension for codes used for the DBR (Margin Contribution) Report. It divides the product size in types based on how they will be handled as packages (P_KT,P_GT,P_2MH ...  )';
