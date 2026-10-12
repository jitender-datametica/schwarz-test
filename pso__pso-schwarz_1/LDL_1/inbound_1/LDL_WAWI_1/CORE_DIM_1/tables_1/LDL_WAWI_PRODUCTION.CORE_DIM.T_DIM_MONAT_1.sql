create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_MONAT_1 (
	MONAT_1 NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	JAHR NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_MONAT primary key (MONAT_1)
)COMMENT='Kalendermonat, Format YYYYMM'
;