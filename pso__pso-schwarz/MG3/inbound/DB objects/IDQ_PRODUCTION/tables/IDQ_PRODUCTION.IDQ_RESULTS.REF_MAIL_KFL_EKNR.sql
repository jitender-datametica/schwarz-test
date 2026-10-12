create or replace TABLE IDQ_PRODUCTION.IDQ_RESULTS.REF_MAIL_KFL_EKNR (
	ID NUMBER(38,0) NOT NULL autoincrement start 1 increment 1 order,
	EK_NR VARCHAR(255),
	constraint OK_ID primary key (ID)
);