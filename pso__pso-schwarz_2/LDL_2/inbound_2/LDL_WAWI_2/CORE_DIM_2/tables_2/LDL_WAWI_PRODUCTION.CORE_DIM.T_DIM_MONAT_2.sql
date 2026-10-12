create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_MONAT_2 (
	MONAT_2 NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	JAHR NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_MONAT primary key (MONAT_2)
)COMMENT='Kalendermonat, Format YYYYMM'
;