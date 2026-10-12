create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_CASH_REGISTER_TYPE_1 (
	CASH_REGISTER_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	CASH_REGISTER_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of cash register. (standard cash register, self-checkout system, vending machine)',
	constraint PK_T_CASH_REGISTER_TYPE primary key (CASH_REGISTER_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the cash register type. It distinguishes between standard cash registers, self-checkout systems and vending machines.'
;