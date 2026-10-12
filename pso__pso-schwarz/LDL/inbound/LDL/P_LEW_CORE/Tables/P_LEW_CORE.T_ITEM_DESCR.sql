create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ITEM_DESCR cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-Retail: makt.matnr; SAP-BW: t_bw_0material_text.matnr',
	LANG_SID NUMBER(38,0) NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE; SAP-Retail: makt.spras; SAP-BW: t_bw_0material_text.spras',
	LANG_CD VARCHAR(20) COMMENT 'Sprache - Code; SAP-Retail: makt.spras; SAP-BW: t_bw_0material_text.spras',
	ITEM_DESCR VARCHAR(100) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung; SAP-Retail: makt.maktx; SAP-BW: t_bw_0material_text.txtmd',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_T_ITEM_DESCR primary key (ITEM_SID, LANG_SID)
)COMMENT='$Revision: 0000 $. ITMD; Artikelbeschreibungen;\n             SAP-Retail: makt;\n             SAP-BW: t_bw_0material_text;\n             ELWIS: t_s_itm_descr;\n             WAWI: t_itm_item_desc'
;
