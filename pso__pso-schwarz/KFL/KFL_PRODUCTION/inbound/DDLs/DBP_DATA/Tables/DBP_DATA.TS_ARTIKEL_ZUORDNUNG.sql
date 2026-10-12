CREATE TABLE DBP_DATA.TS_ARTIKEL_ZUORDNUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	EAN_ID NUMBER(26,0) NOT NULL COMMENT 'Enthält die Haupt-GTIN für KMO',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	WUG_ID NUMBER(38,0) NOT NULL,
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-SORT - TS Zuordnung Artikel zu Artikelhierarchie'
;