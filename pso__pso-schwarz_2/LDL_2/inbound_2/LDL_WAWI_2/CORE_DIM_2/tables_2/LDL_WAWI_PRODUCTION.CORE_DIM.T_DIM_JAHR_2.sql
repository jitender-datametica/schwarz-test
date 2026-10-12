create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_JAHR_2 (
	JAHR NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_JAHR primary key (JAHR)
)COMMENT='Kalenderjahr, Format YYYY'
;