/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SURVEY_SUBMISSION
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:45:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SURVEY_SUBMISSION (
   SURV_SUBMISSION_SID                 NUMBER          NOT NULL COMMENT 'The unique identifier of the filled survey. One ID per each time a customer takes a survey and submits it. (NK  - Survey Platform CD + Survey Submission NR)',
   QUESTION_CD                         VARCHAR(50)     NOT NULL COMMENT 'The unique identifier for question within the survey',
   ANSWER_NR                           VARCHAR(20)     NOT NULL COMMENT 'The unique identifier for answer',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   SURV_PLATFORM_CD                    VARCHAR(20)     COMMENT 'Code identifiying the platform (system) used for the surveys (ex Medallia, Netigate ..)',
   SURV_SUBMISSION_NR                  VARCHAR(50)     COMMENT 'Unique identifier of the survey submission within the Survey Platform',
   SURV_TYPE_CD                        VARCHAR(5)      COMMENT 'Type of the survey (NPS, ..)',
   SURV_METHOD_CD                      VARCHAR(5)      COMMENT 'Code idenfifying the method by which the survey was sent to cusotmer ( online after checkout, by email after delivery...)',
   SURV_CUSTOMER_NR                    VARCHAR(20)     COMMENT 'The unique identifier for customer ( not the same as Lidl customer number)',
   SURV_FORM_SID                       NUMBER          COMMENT 'Unique Indetifier of the  - Surrogate Key based on the following NK (Survey System CD/Survey Platform Name, Survey NR in the survey system, Survey Type CD)',
   SURV_FORM_NR                        VARCHAR(20)     COMMENT 'ID of the survey form in the Survey Platform/System',
   SURV_FORM_NAME                      VARCHAR(100)    COMMENT 'Name of the survey form',
   WEB_BROWSER_NAME                    VARCHAR(100)    COMMENT 'Name of the web browser used during the activity',
   WEB_DEVICE_TYPE_NAME                VARCHAR(100)    COMMENT 'Summarized Types of device used for web browsing (Desktop, Mobile Phone, Tablet, Other)',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   CUST_GENDER_CD                      VARCHAR(20)     COMMENT 'The code for a gender of a customer ( M - Male , F - Female)',
   CUST_LOYALTY_CLASSIFICATION_CD      VARCHAR(5)      COMMENT 'Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)',
   AGE_GROUP_LOWER_VAL                 NUMBER          COMMENT 'The lower bound of the age category in which the customer falls in',
   AGE_GROUP_UPPER_VAL                 NUMBER          COMMENT 'The upper bound of the age category in which the customer falls in',
   AGE_GROUP_TXT                       VARCHAR(30)     COMMENT 'Contactenated upper and lower bound of age group',
   SURV_START_TMSP                     TIMESTAMP_TZ(9) COMMENT 'The date when the survey was started by a customer',
   SURV_COMPLETE_TMSP                  TIMESTAMP_TZ(9) COMMENT 'The date when the survey was completed by a customer',
   ANSWER_TMSP                         TIMESTAMP_TZ(9) COMMENT 'The date when the survey was created by a customer',
   QUESTION_TXT                        VARCHAR(10000)  COMMENT 'The text for question',
   ANSWER_TXT                          VARCHAR(10000)  COMMENT 'The text for the chosen answer',
   ANSWER_VAL                          NUMBER          COMMENT 'Numeric value of the chosen answer',
   ANSWER_WEIGHT                       NUMBER          COMMENT 'The weight of an answer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_SURVEY_SUBMISSION PRIMARY KEY (SURV_SUBMISSION_SID, QUESTION_CD, ANSWER_NR) NOT ENFORCED
 )  COMMENT= 'A survey submissions where customers answers questions about experience of interacting with Lidl webshop or customer support . Provided by external providers ( like Netigate )';
