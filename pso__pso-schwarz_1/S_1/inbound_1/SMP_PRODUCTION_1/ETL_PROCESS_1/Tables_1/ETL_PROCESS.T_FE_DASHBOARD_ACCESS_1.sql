create or replace TABLE SMP_PRODUCTION.ETL_PROCESS.T_FE_DASHBOARD_ACCESS_1 (
	EMAIL VARCHAR(1000) NOT NULL,
	primary key (EMAIL)
)COMMENT='Emails authorized to operate the Schwarz Media Insights Dashboard'
;
