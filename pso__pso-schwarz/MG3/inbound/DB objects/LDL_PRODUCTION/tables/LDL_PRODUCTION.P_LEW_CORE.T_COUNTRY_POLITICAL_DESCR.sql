create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_COUNTRY_POLITICAL_DESCR cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT;\n            CBX: Static 7 (Stiftung);\n            ESB: Static 7 (Stiftung);',
	COUNTRY_POL_SID NUMBER(38,0) NOT NULL COMMENT 'pol. Land; FK auf COUNTRY POLITICAL;\n            SAP-Retail: t005t.land1;\n            SAP-BW: z_ds_t005t.land1;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;',
	LANG_SID NUMBER(38,0) NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE;\n            SAP-Retail: t005t.spras;\n            SAP-BW: z_ds_t005t.spras;\n            CBX: Static @ (Stiftung);\n            ESB: Static @ (Stiftung);',
	LANG_CD VARCHAR(20) COMMENT 'Sprache - Code;\n            SAP-Retail: t005t.spras;\n            SAP-BW: z_ds_t005t.spras;\n            CBX: Static @ (Stiftung);\n            ESB: Static @ (Stiftung);',
	COUNTRY_POL_DESCR VARCHAR(100) COLLATE 'en-ci' COMMENT 'Landesbezeichnung;\n            SAP-Retail: t005t.landx50;\n            SAP-BW: z_ds_t005t.landx50;\n            CBX: Item.ldlCountryOfOrigin.name;\n            ESB: cbxItem.countryOfOrigin.name;',
	NATIONALITY VARCHAR(300) COLLATE 'en-ci' COMMENT 'Bezeichnung der Nationalitat;\n            SAP-Retail: t005t.natio50;\n            SAP-BW: z_ds_t005t.natio50;\n            CBX: NULL;\n            ESB: NULL;',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_T_COUNTRY_POLITICAL_DESCR primary key (COUNTRY_POL_SID, LANG_SID)
)COMMENT='$Revision: 0000 $. CPOD; Bezeichnung der politischen Laender; \nSAP-Retail: t005t;\nSAP-BW: z_ds_t005t;\nELWIS: -;\nCBX: Item.ldlCountryOfOrigin;\nESB: cbxItem.countryOfOrigin;'
;