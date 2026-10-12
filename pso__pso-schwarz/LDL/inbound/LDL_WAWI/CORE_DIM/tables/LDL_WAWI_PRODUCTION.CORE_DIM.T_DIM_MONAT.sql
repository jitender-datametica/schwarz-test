create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_MONAT (
	MONAT NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	JAHR NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_MONAT primary key (MONAT)
)COMMENT='Kalendermonat, Format YYYYMM'
;