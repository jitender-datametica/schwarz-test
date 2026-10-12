create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_GTIN_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	ALTNV_MENGE_EINH_ID VARCHAR(3) NOT NULL COMMENT 'Mengeneinheit für Anzeige',
	LFD_NR NUMBER(38,0) NOT NULL COMMENT 'Laufende Nummer',
	GTIN_ID NUMBER(26,0) NOT NULL COMMENT 'Global Trade Item_2 Number (GTIN)',
	GTIN_TYP_KZ VARCHAR(2) NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Nummerntyp der Global Trade Item_2 Number (z.B. G1 = Hersteller GTIN)',
	HAUPT_GTIN_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kennzeichen Haupt-GTIN (x=1)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_GTIN_ZU primary key (MANDANT_ID, ART_ID, ALTNV_MENGE_EINH_ID, LFD_NR)
)COMMENT='EK-INT - Zuordnungstabelle GTIN (Global Trade Item_2 Number) zum Artikel_2 in SAP PR1 - MEAN_2'
;