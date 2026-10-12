/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SURVEY_PRODUCT_SUBGROUP_REL_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:47:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_survey_product_subgroup_rel_1 (
surv_submission_sid STRING(20) NOT NULL
OPTIONS(description='The unique identifier of the filled survey. One ID per each time a customer takes a survey and submits it. (NK Survey Platform/System CD + Survey Submission NR)'),
prod_subgroup_cd STRING(5) NOT NULL
OPTIONS(description='The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (surv_submission_sid, prod_subgroup_cd) NOT ENFORCED
)
OPTIONS(description='Relational table which shows which Product Subgroups were relevant for the person when he took the survey( what they were buying or were interested in)');