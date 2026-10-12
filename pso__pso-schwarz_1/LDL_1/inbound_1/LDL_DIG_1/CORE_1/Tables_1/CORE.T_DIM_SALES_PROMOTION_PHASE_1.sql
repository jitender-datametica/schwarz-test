CREATE TABLE CORE.T_DIM_SALES_PROMOTION_PHASE_1 (
   SALE_PROMO_PHASE_CD                 VARCHAR(5)      NOT NULL COMMENT 'The unique code for that defines the phase of the promotion  Action (A) or Follow-Up (N - Nachlauf)',
   SALE_PROMO_PHASE_DESCR              VARCHAR(250)    NOT NULL COMMENT 'The textual description for the promotion phase  in group language',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SALES_PROMOTION_PHASE PRIMARY KEY (SALE_PROMO_PHASE_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the phase of the promotion  Action or Follow-Up';
