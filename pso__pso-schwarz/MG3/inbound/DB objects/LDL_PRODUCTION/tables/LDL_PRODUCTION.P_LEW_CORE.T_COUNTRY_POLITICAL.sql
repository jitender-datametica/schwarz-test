create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_COUNTRY_POLITICAL cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT\n            CBX: Static 7 (Stiftung);\n            ESB: Static 7 (Stiftung);',
	COUNTRY_POL_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key COUNTRY POLITICAL;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;',
	SRC_LAND1 VARCHAR(20) COMMENT 'Quellsystemschluessel SAP-Retail: t005.land1;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;',
	COUNTRY_POL_NAME VARCHAR(100) COLLATE 'en-ci' COMMENT 'Name des Landes in Stiftungssprache; SAP-Retail: t005t.landx50;\n            CBX: Item.ldlCountryOfOrigin.name;\n            ESB: cbxItem.countryOfOrigin.name;',
	CURR_SID NUMBER(38,0) COMMENT 'Landeswaehrung; FK auf CURRENCY; SAP-Retail: t005.waers',
	LANG_SID NUMBER(38,0) COMMENT 'Default-Sprache; FK auf LANGUAGE; t005.spras',
	CURR_CD VARCHAR(20) COMMENT 'Landeswaehrung - Code; SAP-Retail: t005.waers',
	LANG_CD VARCHAR(20) COMMENT 'Default-Sprache; SAP-Retail: t005.spras',
	ISO_CODE2 VARCHAR(20) COMMENT '2stelliger ISO Country Code; SAP-Retail: t005.intca',
	ISO_CODE3 VARCHAR(20) COMMENT '3stelliger ISO Country Code; SAP-Retail: t005.intca3',
	MEMBER_EU_FG NUMBER(38,0) COMMENT 'Mitglied der Europaeischen Union; SAP-Retail: t005.xegld',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_COUNTRY_POLITICAL primary key (COUNTRY_POL_SID)
)COMMENT='$Revision: 0000 $. Politische Laender'
;