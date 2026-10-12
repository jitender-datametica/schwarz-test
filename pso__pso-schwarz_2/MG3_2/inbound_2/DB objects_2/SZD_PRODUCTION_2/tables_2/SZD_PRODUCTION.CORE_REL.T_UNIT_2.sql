create or replace TABLE SZD_PRODUCTION.CORE_REL.T_UNIT_2 (
	UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter)',
	UNIT_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key - Unit_2 code as a technical identifier of the unit_2 from the source system or manually maintained (e.g. C for Celsius degree, Kg for Kilogramm, URGENT for Urgency in Days)',
	UNIT_NAME VARCHAR(100) NOT NULL COMMENT 'Full name of the unit_2 (e.g. celsius degree, Prio, Urgency in days)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_UNIT primary key (UNIT_ID)
)COMMENT='Minor Entity - with units (e.g. plastic materials, production line parameter). The unit_2 in which a quantity is expressed. This includes mostly physical units, such as kilogram, meters or seconds, but also units such as slices or pieces. Source - Partially manual'
;