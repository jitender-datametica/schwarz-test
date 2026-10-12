CREATE TABLE CORE.T_DIM_TOUR_OPERATOR_CONTRACT_TYPE_2 (
   TOUR_OPERATOR_CONTRACT_TYPE_CD      VARCHAR(5)      NOT NULL COMMENT 'The code for the type of contract for Tour_2 Operator LT ( Iframe , mittelbar,  unmittelbar)',
   TOUR_OPERATOR_CONTRACT_TYPE_DESCR   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of contract for Tour_2 Operator LT ( Iframe , mittelbar,  unmittelbar)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TOUR_OPERATOR_CONTRAC PRIMARY KEY (TOUR_OPERATOR_CONTRACT_TYPE_CD)
       NOT ENFORCED
)COMMENT = 'This minor dimension that defines the type of contract for Tour_2 Operator LT ( Iframe , mittelbar,  unmittelbar)
          ';
