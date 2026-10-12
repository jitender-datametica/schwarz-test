/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SURVEY_METHOD_2
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:34:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_survey_method_2 (
surv_method_cd STRING(5) NOT NULL
OPTIONS(description='Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)'),
surv_method_descr STRING(250)
OPTIONS(description='Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (surv_method_cd) NOT ENFORCED
) OPTIONS(description='This dimension describes survey methods (like pop-up at checkout, E-Mail after delivery, ...)');