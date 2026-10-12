create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_VW_WUP_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebsweges',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	RABATT_ZUL_FG NUMBER(38,0) NOT NULL COMMENT 'Flag zeigt an, ob ein Rabatt zulässig ist. Aus rbzul. Zulääsig = 1, sonst 0',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_VW_WUP_ZU primary key (MANDANT_ID, WUP_ID, VW_ID, ART_ID)
)COMMENT='AIS_KMO - Artikel-Markt_Vertriebsweg Tabelle aus der Quelle wlk2'
;