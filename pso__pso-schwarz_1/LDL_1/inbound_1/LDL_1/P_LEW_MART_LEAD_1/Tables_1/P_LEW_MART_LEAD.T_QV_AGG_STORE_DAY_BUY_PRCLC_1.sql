/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_BUY_PRCLC_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 04.05.2020 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_BUY_PRCLC_1 CLUSTER BY (client_id, dat_formdate)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Landeskennzeichen',
	CLIENT_DESC VARCHAR(35) COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
	ACCOUNT_MANAGER_ID NUMBER(38,0) COMMENT 'Vertriebsleiter-Nr.',
	ACCOUNT_MANAGER_NAME VARCHAR(50) COLLATE 'en-ci' COMMENT 'Vertriebsleiter-Name',
	SALES_MANAGER_ID NUMBER(38,0) COMMENT 'Bezirksleiter-Nr.',
	SALES_MANAGER_NAME VARCHAR(50) COLLATE 'en-ci' COMMENT 'Bezirksleiter-Name',
	MOVE_TO_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'Filial-Nr. nach letztem Filialumzug',
	MOVE_STORE_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Filialname nach letztem Filialumzug',
	WH_ID NUMBER(38,0) COMMENT 'Gesellschaftsnummer',
	WH_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Gesellschaftsbezeichnung',
	WH_ID_EXP NUMBER(38,0) COMMENT 'Gesellschafts-Nr.-exp',
	ASPECT_ID NUMBER(38,0) COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	ASPECT_DESC VARCHAR(4) COLLATE 'en-ci' COMMENT 'Gesellschaftsform Bezeichnung',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'Iso-Code Waehrung',
	CURR_TOT_ID NUMBER(38,0) COMMENT 'Fixe Werte fuer sonst Client_Id',
	DAT_FORMDATE DATE NOT NULL COMMENT 'Aenderungsdatum',
	MIS_STORE_ACTIVE_FG NUMBER(38,0) COMMENT 'MIS Flag zur Kennzeichnung aktiver Filialen',
	VAL_PR_DIFF_GROSS_SFO_ASIS NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (gross value)',
	VAL_PR_DIFF_GROSS_SFO_ASIS_PY NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (gross value), Vorjahr',
	VAL_PR_DIFF_NET_SFO_ASIS NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (net value)',
	VAL_PR_DIFF_NET_SFO_ASIS_PY NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (net value), Vorjahr',
	VAL_PR_DIFF_GROSS_DEL_ASIS NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (gross value)',
	VAL_PR_DIFF_GROSS_DEL_ASIS_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (gross value), Vorjahr',
	VAL_PR_DIFF_NET_DEL_ASIS NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (net value)',
	VAL_PR_DIFF_NET_DEL_ASIS_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (net value), Vorjahr',
	VAL_PR_ADJ_GROSS_SFO_ASIS NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (gross value)',
	VAL_PR_ADJ_GROSS_SFO_ASIS_PY NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (gross value), Vorjahr',
	VAL_PR_ADJ_NET_SFO_ASIS NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (net value)',
	VAL_PR_ADJ_NET_SFO_ASIS_PY NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (net value), Vorjahr',
	VAL_RETAIL_GROSS_ASIS NUMBER(19,5) COMMENT 'Umsatz (gross value)',
	VAL_RETAIL_GROSS_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (gross value), Vorjahr',
	VAL_RETAIL_NET_ASIS NUMBER(19,5) COMMENT 'Umsatz (net value)',
	VAL_RETAIL_NET_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (net value), Vorjahr',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load Identification',
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Insert record timestamp',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Update record timestamp',
	UNIQUE (CLIENT_ID, MOVE_TO_STORE_ID, CURRENCY_ISO_CD, DAT_FORMDATE)
)COMMENT='Table contains the base data for the QuickView cube Ware Einkaufen. Data is provided by store and day.'
;