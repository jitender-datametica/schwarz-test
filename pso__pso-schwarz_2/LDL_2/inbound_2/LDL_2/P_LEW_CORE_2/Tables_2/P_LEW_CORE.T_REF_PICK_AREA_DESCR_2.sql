create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_PICK_AREA_DESCR_2 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION_2',
	LANG_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key REPORT LANGUAGE',
	LANG_CD VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Sprache - Code; ',
	PICK_AREA_ID NUMBER(38,0) NOT NULL COMMENT 'Greif-/Lagerzone / Kommisionierungsbereich',
	PICK_AREA_DESCR VARCHAR(100) NOT NULL COMMENT 'Greif-/Lagerzone - Beschreibung',
	PICK_MAIN_AREA_ID NUMBER(38,0) NOT NULL COMMENT 'Haupt-Greif-/Lagerzone  / Kommisionierungsbereich',
	PICK_MAIN_AREA_DESCR VARCHAR(100) NOT NULL COMMENT 'Haupt-Greif-/Lagerzone - Beschreibung',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_PICK_AREA_DESCR primary key (LOC_SID, PICK_AREA_ID, LANG_SID)
)COMMENT='$Revision: 0000 $. Greifzone / Kommissionierungsbereich\n             fuer WHs aus SAP-Laendern wird die Lagerzone assoziiert\n             Bsp: Picking Area 16 : Verbrauchsmaterial --> Picking Main Area 10 (=HR HochRegal)\n             ...\n             WAWI-DWH: t_itm_pp_picking_area'
;
