create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_PALLET_TYPE_1 (
	PALLET_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Code for the pallet type, i.e. EP, DD, AE, etc.',
	PALLET_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'Description of the main pallet type.',
	PALLET_TYPE_FACTOR NUMBER(38,5) COMMENT 'Conversion factor of logical pallet to euro pallet equivalent.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_PALLET_TYPE primary key (PALLET_TYPE_CD)
)COMMENT='Table holds the pallet types, as well as the conversion factor to the equivalent euro pallet. Number of pallets * factor = number of pallets in terms of euro pallets.'
;
