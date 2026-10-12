/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_WGI_PRCLC_1
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
#-------------------------------------------------------------------------------
# Table DDL
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_WGI_PRCLC_1 CLUSTER BY (client_id, dat_formdate)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Landeskennzeichen',
	CLIENT_DESC VARCHAR(35) COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
	COUNTRY_GROUP_ID NUMBER(38,0) COMMENT 'Landesgruppe Kennzeichen',
	COUNTRY_GROUP_DESC VARCHAR(60) COLLATE 'en-ci' COMMENT 'Landesgruppe Bezeichnung',
	GL_REGION_ID NUMBER(38,0) COMMENT 'Geschaeftsleitungsregion ID',
	GL_REGION_DESC VARCHAR(60) COLLATE 'en-ci' COMMENT 'Beschreibung Geschaeftsleitungsregion',
	WH_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsnummer',
	WH_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Gesellschaftsbezeichnung',
	ASPECT_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	ASPECT_DESC VARCHAR(4) COLLATE 'en-ci' COMMENT 'Gesellschaftsform Bezeichnung',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'Iso-Code Waehrung',
	CURR_TOT_ID NUMBER(38,0) COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	ITEMGROUP_INT_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelgruppe international - WAWI Code',
	ITEMGROUP_INT_DESC VARCHAR(40) COLLATE 'en-ci' COMMENT 'Artikelgruppe International - Bezeichnung',
	MIS_STORE_ACTIVE_FG NUMBER(38,0) COMMENT 'MIS Flag zur Kennzeichnung aktiver Filialen',
	DAT_FORMDATE DATE NOT NULL COMMENT 'Aenderungsdatum',
	CNT_MISS_ITEM NUMBER(38,0) COMMENT 'Anzahl Fehlartikel pro Gesellschaft und Tag_1',
	CNT_MISS_ITEM_PY NUMBER(38,0) COMMENT 'Anzahl Fehlartikel pro Gesellschaft und Tag_1, Vorjahr',
	CNT_DAT_MISS_ITEM NUMBER(38,0) COMMENT 'Anzahl Tage (Fehlartikel)',
	CNT_DAT_MISS_ITEM_PY NUMBER(38,0) COMMENT 'Anzahl Tage (Fehlartikel), Vorjahr',
	VAL_ROC_PRCLC_WH FLOAT COMMENT 'Reichweite Lager - Nominator in EP',
	VAL_ROC_PRCLC_WH_PY FLOAT COMMENT 'Reichweite Lager - Nominator in EP, Vorjahr',
	AVG_STC_WH FLOAT COMMENT 'durchschn.-Bestand des Artikles in EP',
	AVG_STC_WH_PY FLOAT COMMENT 'durchschn.-Bestand des Artikles in EP, Vorjahr',
	VAL_RETAIL_GROSS_EJR NUMBER(19,5) COMMENT 'Umsatz EJR (gross value)',
	VAL_RETAIL_GROSS_EJR_PY NUMBER(19,5) COMMENT 'Umsatz EJR (gross value), Vorjahr',
	VAL_RETAIL_GROSS_TOTAL_EJR NUMBER(19,5) COMMENT 'Umsatz EJR uebergreifend (gross value)',
	VAL_RETAIL_GROSS_TOTAL_EJR_PY NUMBER(19,5) COMMENT 'Umsatz EJR uebergreifend (gross value), Vorjahr',
	VAL_RETAIL_NET_EJR NUMBER(19,5) COMMENT 'Umsatz EJR (net value)',
	VAL_RETAIL_NET_EJR_PY NUMBER(19,5) COMMENT 'Umsatz EJR (net value), Vorjahr',
	VAL_RETAIL_NET_TOTAL_EJR NUMBER(19,5) COMMENT 'VK_1 netto uebergreifend',
	VAL_RETAIL_NET_TOTAL_EJR_PY NUMBER(19,5) COMMENT 'VK_1 netto uebergreifend, Vorjahr',
	VAL_PR_ADJ_GROSS_SFO_ASIS NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (gross value)',
	VAL_PR_ADJ_GROSS_SFO_ASIS_PY NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (gross value), Vorjahr',
	VAL_PR_ADJ_NET_SFO_ASIS NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (net value)',
	VAL_PR_ADJ_NET_SFO_ASIS_PY NUMBER(19,5) COMMENT 'Preisveraenderungen ohne Preisgebietsdifferenzen (net value), Vorjahr',
	VAL_PR_DIFF_GROSS_DEL NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (gross value)',
	VAL_PR_DIFF_GROSS_DEL_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (gross value), Vorjahr',
	VAL_PR_DIFF_NET_DEL NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (net value)',
	VAL_PR_DIFF_NET_DEL_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Basis (net value), Vorjahr',
	VAL_PR_DIFF_GROSS_SFO NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (gross value)',
	VAL_PR_DIFF_GROSS_SFO_PY NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (gross value), Vorjahr',
	VAL_PR_DIFF_NET_SFO NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (net value)',
	VAL_PR_DIFF_NET_SFO_PY NUMBER(19,5) COMMENT 'SQL PV-Preisdifferenzen SFO Basis (net value), Vorjahr',
	VAL_BUYING_NET_RCV NUMBER(19,5) COMMENT 'EK netto inkl. Sonderkonditionen',
	VAL_BUYING_NET_RCV_PY NUMBER(19,5) COMMENT 'EK netto inkl. Sonderkonditionen, Vorjahr',
	VAL_RETAIL_NET_RCV NUMBER(19,5) COMMENT 'VK_1 netto',
	VAL_RETAIL_NET_RCV_PY NUMBER(19,5) COMMENT 'VK_1 netto, Vorjahr',
	VAL_ADJ_GROSS_SFO_WH NUMBER(19,5) COMMENT 'Abschriften_1 Lager (gross value)',
	VAL_ADJ_GROSS_SFO_WH_PY NUMBER(19,5) COMMENT 'Abschriften_1 Lager (gross value), Vorjahr',
	VAL_ADJ_NET_SFO_WH NUMBER(19,5) COMMENT 'Abschriften_1 Lager (net value)',
	VAL_ADJ_NET_SFO_WH_PY NUMBER(19,5) COMMENT 'Abschriften_1 Lager (net value), Vorjahr',
	VAL_PRDFF_RTRN_GRO_SFO NUMBER(19,5) COMMENT 'BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value)',
	VAL_PRDFF_RTRN_GRO_SFO_PY NUMBER(19,5) COMMENT 'BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value), Vorjahr',
	VAL_PRDFF_RTRN_NET_SFO NUMBER(19,5) COMMENT 'BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value)',
	VAL_PRDFF_RTRN_NET_SFO_PY NUMBER(19,5) COMMENT 'BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value), Vorjahr',
	VAL_ADJ_GROSS_SFO_STORE NUMBER(19,5) COMMENT 'Abschriften_1 Filiale (gross value)',
	VAL_ADJ_GROSS_SFO_STORE_PY NUMBER(19,5) COMMENT 'Abschriften_1 Filiale (gross value), Vorjahr',
	VAL_ADJ_NET_SFO_STORE NUMBER(19,5) COMMENT 'Abschriften_1 Filiale (net value)',
	VAL_ADJ_NET_SFO_STORE_PY NUMBER(19,5) COMMENT 'Abschriften_1 Filiale (net value), Vorjahr',
	QTY_SALES_EJR NUMBER(19,5) COMMENT 'Abverkauf Stk./kg',
	QTY_SALES_EJR_PY NUMBER(19,5) COMMENT 'Abverkauf Stk./kg, Vorjahr',
	CNT_DAY_STORE NUMBER(38,0) COMMENT 'Anzahl Fililale Tage',
	CNT_DAY_STORE_PY NUMBER(38,0) COMMENT 'Anzahl Fililale Tage, Vorjahr',
	VAL_RETAIL_NET_FA_EJR NUMBER(19,5) COMMENT 'Umsatz Food Aktion_1 EJR (net value)',
	VAL_RETAIL_NET_FA_EJR_PY NUMBER(19,5) COMMENT 'Umsatz Food Aktion_1 EJR (net value), Vorjahr',
	VAL_RETAIL_NET_TOTAL_FA_EJR NUMBER(19,5) COMMENT 'VK_1 Food Aktion_1 netto uebergreifend',
	VAL_RETAIL_NET_TOTAL_FA_EJR_PY NUMBER(19,5) COMMENT 'VK_1 Food Aktion_1 netto uebergreifend, Vorjahr',
	VAL_PR_DIFF_NET_FA_DEL NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Food Aktion_1 Basis (net value)',
	VAL_PR_DIFF_NET_FA_DEL_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen ALM Food Aktion_1 Basis (net value), Vorjahr',
	VAL_PR_DIFF_NET_FA_SFO NUMBER(19,5) COMMENT 'PV-Preisdifferenzen SFO Food Aktion_1 Basis (net value)',
	VAL_PR_DIFF_NET_FA_SFO_PY NUMBER(19,5) COMMENT 'PV-Preisdifferenzen SFO Food Aktion_1 Basis (net value), Vorjahr',
	VAL_RTL_RL_NET_FA_SFO_ASIS NUMBER(19,5) COMMENT 'PVs Wert Basismetrik Food Aktion_1 (net value)',
	VAL_RTL_RL_NET_FA_SFO_ASIS_PY NUMBER(19,5) COMMENT 'PVs Wert Basismetrik Food Aktion_1 (net value), Vorjahr',
	VAL_BUYING_NET_FA_RCV NUMBER(19,5) COMMENT 'EK netto inkl. Sonderkonditionen Food Aktion_1',
	VAL_BUYING_NET_FA_RCV_PY NUMBER(19,5) COMMENT 'EK netto inkl. Sonderkonditionen Food Aktion_1, Vorjahr',
	VAL_RETAIL_NET_FA_RCV NUMBER(19,5) COMMENT 'VK_1 netto Food Aktion_1',
	VAL_RETAIL_NET_FA_RCV_PY NUMBER(19,5) COMMENT 'VK_1 netto Food Aktion_1, Vorjahr',
	QTY_SALES_FA_EJR NUMBER(19,5) COMMENT 'Abverkauf Stk./kg nur Food Action',
	QTY_SALES_FA_EJR_PY NUMBER(19,5) COMMENT 'Abverkauf Stk./kg nur Food Action, Vorjahr',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load Identification',
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Insert record timestamp',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Update record timestamp',
	UNIQUE (CLIENT_ID, WH_ID, ASPECT_ID, CURRENCY_ISO_CD, ITEMGROUP_INT_ID, DAT_FORMDATE)
)COMMENT='Table'
;