create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_TAG_GLD_2 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	EK_GLD NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_TAG_GLD primary key (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT)
)COMMENT='AIS_KMO - Zur Anreicherung der Tabelle artbew_2 mit gld. Die Daten werden aus lagerbew_det_2 gewonnen und für begrenzte Zeit_2 in dieser Tabelle abgelegt - MULTISET.'
;