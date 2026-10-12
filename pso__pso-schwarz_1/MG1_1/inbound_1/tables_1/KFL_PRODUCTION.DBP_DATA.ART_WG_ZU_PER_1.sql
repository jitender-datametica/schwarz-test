create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WG_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_1 -> Counter +1',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'Warengruppe',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode',
	WUG_ID NUMBER(38,0) NOT NULL COMMENT 'Warenuntergruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='TP2_AIS - Artikel_1 Warengruppe Zuordnung'
;