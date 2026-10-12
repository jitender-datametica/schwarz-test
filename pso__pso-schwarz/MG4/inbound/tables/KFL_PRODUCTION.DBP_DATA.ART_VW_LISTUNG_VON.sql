create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_VW_LISTUNG_VON (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebsweges',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	DAT_VON DATE NOT NULL COMMENT 'Datum der letzten Listungsänderung. Pro Schlüssel ist nur das letzte Datum gespeichert',
	SM_ID NUMBER(38,0) NOT NULL DEFAULT -9 COMMENT 'Hier: groesste sm_id mit einer durchgaengigen Listung',
	DAT_ERST_LISTUNG DATE NOT NULL COMMENT 'Datum der ersten Listung',
	KSM_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' DEFAULT '-9' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_VW_LISTUNG_VON primary key (MANDANT_ID, VW_ID, ART_ID)
)COMMENT='TP2_AIS - Pro Artikel und Vertriebsweg wird die Durchgängigkeit der Listung angezeigt'
;