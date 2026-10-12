create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_WAREHOUSE_DOCKING_GATE_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT.',
	WH_LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION.',
	WH_DOCKING_GATE_NR NUMBER(38,0) NOT NULL COMMENT 'Identifier of the docking gate at the warehouse where the transportaion vehicle docks for loading and unloading.',
	WH_STAGING_AREA_CD VARCHAR(100) COMMENT 'Code for the warehouse staging area to which the docking gate belongs.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_WAREHOUSE_DOCKING_GATE primary key (WH_LOC_SID, WH_DOCKING_GATE_NR)
)COMMENT='Table contains docking gate numbers in warehouse, which are where the transportation vehicle docks for loading and unloading, and the connection to the respective staging area.\n             Source:\n             WAWI table T171_GINGATES_2\n             EWM table /SCWM/TDOOR_STA'
;
