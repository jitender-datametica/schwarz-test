create or replace TABLE IDQ_PRODUCTION.IDQ_RESULTS.REF_MAIL_KFL_MAIL_1 (
	ID NUMBER(38,0) NOT NULL autoincrement start 1 increment 1 order,
	MAIL VARCHAR(255) NOT NULL,
	constraint PK_ID primary key (ID)
);