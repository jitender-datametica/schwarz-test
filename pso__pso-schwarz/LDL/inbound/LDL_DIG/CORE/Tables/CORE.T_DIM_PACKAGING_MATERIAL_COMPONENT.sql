CREATE TABLE CORE.T_DIM_PACKAGING_MATERIAL_COMPONENT (
	PACK_MATERIAL_NR VARCHAR(20) NOT NULL COMMENT 'The packaging material number (e..g 420000026,  420000028)',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	PACK_COMPOS_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'Verpackung II',
	PACK_COMPOS_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Verpackung III',
	LDPCR_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used LDPCR (Low Density Post-Consumer-Recycled) in kg (Unit).',
	LDPE_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used LDPE (Low Density Polyethylene) in kg (Unit).',
	PP_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used PP (Polypropylene) in kg (Unit).',
	PE_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used PE (Polyethylene) in kg (Unit).',
	THERMO_ECO_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used Thermo-Eco-Labels in kg (Unit).',
	PAPER_COMPOS_KG NUMBER(38,5) COMMENT 'Weight of used paper in kg (Unit).',
	CORRUGATED_CARDBOARD_KG NUMBER(38,5) COMMENT 'Weight of used recycelt corrugated fiberboard in kg (Unit).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME  VARCHAR(100) COMMENT 'The name of the source tables',
	CONSTRAINT PK_T_DIM_PACKAGING_MATERIAL_COMPONENT PRIMARY KEY (PACK_MATERIAL_NR,PACK_COMPOS_GROUP_NAME,PACK_COMPOS_TYPE_NAME)
)COMMENT='This dimension defines the packaging material information (sourced from the product master data starting with 400..)'
;