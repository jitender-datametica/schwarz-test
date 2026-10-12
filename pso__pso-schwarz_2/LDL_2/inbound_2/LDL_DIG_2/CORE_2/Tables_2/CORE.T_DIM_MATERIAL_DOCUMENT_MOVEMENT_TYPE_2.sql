CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_MOVEMENT_TYPE_2 (
	MATERIAL_DOC_MOV_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for product movement  (101, 601 , etc)',
	MATERIAL_DOC_MOV_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description for product movement  ( Goods receipt , Goods issue/goods delivery, etc )',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_MOVEMENT_TYPE PRIMARY KEY (MATERIAL_DOC_MOV_TYPE_CD)
)COMMENT='The minor dimension describing types of product movement in warehouse on position level of warehouse-movement-document.'
;