CREATE TABLE CORE.T_FACT_SURVEY (
	WSHOP_CD VARCHAR(5) COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
	ANSWERSET_NR VARCHAR(20) NOT NULL COMMENT 'The unique identifier for answerset',
	SURV_NR VARCHAR(20) NOT NULL COMMENT 'The unique identifier for survey',
	SURV_CUSTOMER_NR VARCHAR(20) NOT NULL COMMENT 'The unique identifier for customer ( not the same as Lidl customer number)',
	SURV_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'Type of the survey',
	SURV_CREATE_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The date when the survey was started by a customer',
	SURV_COMPLETE_TMSP TIMESTAMP_TZ(9) COMMENT 'The date when the survey was completed by a customer',
	ANSWER_CREATE_TMSP TIMESTAMP_TZ(9) COMMENT 'The date when the survey was created by a customer',
	QUESTION_NR VARCHAR(20) NOT NULL COMMENT 'The unique identifier for question',
	QUESTION_TEXT VARCHAR(10000) COMMENT 'The text for question',
	ANSWER_NR VARCHAR(20) NOT NULL COMMENT 'The unique identifier for answer',
	ANSWER_TEXT VARCHAR(10000) COMMENT 'The text for the chosen answer',
	ANSWER_VAL NUMBER(38,0) COMMENT 'Numeric value of the chosen answer',
	ANSWER_WEIGHT NUMBER(38,0) COMMENT 'The weight of an answer',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_FACT_SURVEY PRIMARY KEY (ANSWERSET_NR, SURV_NR, SURV_TYPE_CD, QUESTION_NR, ANSWER_NR)
)COMMENT='A survey where customers answers questions about experience of interacting with Lidl webshop or customer support . Provided by external providers ( like Netigate )'
;