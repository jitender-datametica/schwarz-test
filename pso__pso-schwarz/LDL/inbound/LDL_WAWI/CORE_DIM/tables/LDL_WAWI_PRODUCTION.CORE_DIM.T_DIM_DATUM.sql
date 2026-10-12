create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_DATUM (
	DATUM DATE NOT NULL COMMENT 'Manuell befüllt',
	MONAT NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	JAHR NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_DATUM primary key (DATUM)
)COMMENT='Datum, Format YYYY-MM-DD'
;