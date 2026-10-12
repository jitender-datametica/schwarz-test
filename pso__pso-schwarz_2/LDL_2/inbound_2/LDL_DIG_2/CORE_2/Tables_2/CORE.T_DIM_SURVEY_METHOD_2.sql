/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SURVEY_METHOD_2
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:34:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SURVEY_METHOD_2 (
   SURV_METHOD_CD                      VARCHAR(5)      NOT NULL COMMENT 'Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)',
   SURV_METHOD_DESCR                   VARCHAR(250)    COMMENT 'Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SURVEY_METHOD PRIMARY KEY (SURV_METHOD_CD) NOT ENFORCED
 )  COMMENT= 'This dimension describes survey methods (like pop-up at checkout, E-Mail after delivery, ...)';
