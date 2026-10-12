create or replace TABLE KFL_PRODUCTION.DBP_DATA.BAUSTEIN_ART_ZU_PER_2 (
	BAUSTEIN_ID NUMBER(18,0) NOT NULL COMMENT 'ID eines Sortimentsbausteins',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            ',
	DAT_VON DATE COMMENT 'Beginn der Gültigkeitsperiode\n            ',
	AKZ_ID VARCHAR(1) COLLATE 'en-ci' COMMENT 'Artikelkennzeichen in der Form\n            ''A'' = Artikel_2 über sich selbst gelistet\n            ''D'' = Artikel_2 über Display (Stückliste Display) gelistet\n            ''K'' = Artikel_2 als Komponente über Display gelistet',
	STUECKLISTE_ID NUMBER(38,0) NOT NULL COMMENT 'ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel_2 zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BAUSTEIN_ART_ZU_PER primary key (BAUSTEIN_ID, MANDANT_ID, ART_ID, DAT_BIS, STUECKLISTE_ID)
)COMMENT='TP2/7 AIS - Zuordnung Baustein zu Artikel_2 - MULTISET - SAP RET Tabelle WSOP_2'
;