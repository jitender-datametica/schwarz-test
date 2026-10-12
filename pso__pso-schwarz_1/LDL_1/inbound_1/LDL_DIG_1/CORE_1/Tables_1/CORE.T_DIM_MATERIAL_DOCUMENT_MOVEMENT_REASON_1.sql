CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_MOVEMENT_REASON_1 (
	MATERIAL_DOC_MOV_REASON_CD VARCHAR(20) NOT NULL COMMENT 'A code for the  reason for the goods movement ',
	MATERIAL_DOC_MOV_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A description for the  reason for the goods movement ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_MOVEMENT_REASON PRIMARY KEY (MATERIAL_DOC_MOV_REASON_CD)
)COMMENT='The Movement Indicator is containing single letter codes to identify the  reason for the goods movement such as goods movement w/o reference, goods movement for purchase order, goods movement for production order etc.'
;