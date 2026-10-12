create or replace TABLE KFL_PRODUCTION.DBP_DATA.BAUSTEIN_ART_ZU_PER (
	BAUSTEIN_ID NUMBER(18,0) NOT NULL COMMENT 'ID eines Sortimentsbausteins',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            ',
	DAT_VON DATE COMMENT 'Beginn der Gültigkeitsperiode\n            ',
	AKZ_ID VARCHAR(1) COLLATE 'en-ci' COMMENT 'Artikelkennzeichen in der Form\n            ''A'' = Artikel über sich selbst gelistet\n            ''D'' = Artikel über Display (Stückliste Display) gelistet\n            ''K'' = Artikel als Komponente über Display gelistet',
	STUECKLISTE_ID NUMBER(38,0) NOT NULL COMMENT 'ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BAUSTEIN_ART_ZU_PER primary key (BAUSTEIN_ID, MANDANT_ID, ART_ID, DAT_BIS, STUECKLISTE_ID)
)COMMENT='TP2/7 AIS - Zuordnung Baustein zu Artikel - MULTISET - SAP RET Tabelle WSOP'
;