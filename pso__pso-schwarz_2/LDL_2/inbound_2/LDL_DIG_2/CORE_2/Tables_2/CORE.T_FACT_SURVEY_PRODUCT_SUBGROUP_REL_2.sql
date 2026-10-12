/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SURVEY_PRODUCT_SUBGROUP_REL_2
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:47:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SURVEY_PRODUCT_SUBGROUP_REL_2 (
   SURV_SUBMISSION_SID                 VARCHAR(20)     NOT NULL COMMENT 'The unique identifier of the filled survey. One ID per each time a customer takes a survey and submits it. (NK Survey Platform/System CD + Survey Submission NR)',
   PROD_SUBGROUP_CD                    VARCHAR(5)      NOT NULL COMMENT 'The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_SURVEY_PRODUCT_SUBGROUP_REL PRIMARY KEY (SURV_SUBMISSION_SID, PROD_SUBGROUP_CD) NOT ENFORCED
 )  COMMENT= 'Relational table which shows which Product Subgroups were relevant for the person when he took the survey( what they were buying or were interested in)';
