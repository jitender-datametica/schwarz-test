/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_GOODWILL_REASON
   GENERATED FROM POWERDESIGNER ON Freitag, 15. Dezember 2023 15:13:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_GOODWILL_REASON (
   GOODWILL_REASON_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the goodwill reason.',
   GOODWILL_REASON_DESCR_EN            VARCHAR(250)    NOT NULL COMMENT 'The textual description of the goodwill reason in English.',
   GOODWILL_REASON_DESCR_DE            VARCHAR(250)    NOT NULL COMMENT 'The textual description of the goodwill reason in German.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_GOODWILL_REASON PRIMARY KEY (GOODWILL_REASON_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension describes the available goodwill reasons';
