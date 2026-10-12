/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MILESTONE_PROGRESS_STATUS_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MILESTONE_PROGRESS_STATUS_1 (
   MILESTONE_PROGRESS_DETAIL_CD        VARCHAR(50)     NOT NULL COMMENT 'Code for a more detailed status_1 of progress of a lot/container refered to as ''Container Status_1 1''',
   MILESTONE_PROGRESS_OVERALL_CD       VARCHAR(50)     NOT NULL COMMENT 'Code for broader status_1 of progress of a lot/container refered to as ''Container Status_1 2''',
   MILESTONE_PROGRESS_DETAIL_DESCR     VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - Descriptive text of a more detailed progress status_1 of a lot/container',
   MILESTONE_PROGRESS_OVERALL_DESCR    VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - Descriptive text of a broader progress status_1 of a lot/container',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_MILESTONE_PROGRESS_STATUS PRIMARY KEY (MILESTONE_PROGRESS_DETAIL_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Combination of detailed status_1 codes with a more broader classification of status_1 and it''s corresponding descriptions. - Source - Manual';
