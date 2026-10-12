CREATE TABLE DBP_DATA.ART_GUID_ZU_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_GUID_C22 VARCHAR(22) NOT NULL COMMENT 'Materialnummer CHAR 22',
	ART_GUID VARCHAR(32) COMMENT 'Materialnummer RAW 16',
	ART_ID INTEGER COMMENT 'Artikelnummer im DWH. Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Zuordnung Artikel_2 GUID zu Artikelnummer'
;