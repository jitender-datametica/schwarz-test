create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_SEGMENT (
	SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key SEGMENT.',
	SRC_SEGMENT_NR VARCHAR(250) COMMENT 'Identifier of the segment in the segmentation in the source system, same segment numbers may exist for different segmentations within the same model, and in different models.',
	SEGMENT_NAME VARCHAR(100) COMMENT 'Name of the segment in the segmentation.',
	SEGMENT_DESCR VARCHAR(250) COMMENT 'Description of the segment in the segmentation.',
	SEGMENTATION_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key SEGMENTATION.',
	SEGMENTATION_NAME VARCHAR(100) COMMENT 'Name of the segmentation in the model.',
	MODEL_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key MODEL.',
	MODEL_NAME VARCHAR(100) COMMENT 'Name of the model.',
	MODEL_AREA_CD VARCHAR(100) NOT NULL COMMENT 'sprechender Code, CX, LDL+, AP.',
	MODEL_GROUP_CD VARCHAR(100) NOT NULL COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH.',
	constraint PK_T_REF_SEGMENT primary key (SEGMENT_SID)
)COMMENT='$Revision: 0000 $. A segment is a target bucket in a segmentation.'
;
