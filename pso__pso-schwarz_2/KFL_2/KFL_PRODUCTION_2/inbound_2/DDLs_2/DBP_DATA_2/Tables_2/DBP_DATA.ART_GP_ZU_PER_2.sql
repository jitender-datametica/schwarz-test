create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_GP_ZU_PER_2 (
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode\n            ',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_2 zusammen mit dem Attribut gp_id eindeutig zu identifizieren.  1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
	GP_ART_ID VARCHAR(40) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Lieferantenartikelnummer',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: ''9999-12-31''',
	HERST_ID NUMBER(38,0) NOT NULL DEFAULT -2 COMMENT 'Hersteller - ID\n            \n            (AIS: im Artikelstamm)\n            ist zur Löschung vorgesehen, Hersteller wird in Zukunft über herst_fg im gp_2 abgebildet',
	MHD_ZEITRAUM_DZ NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Restlaufzeit des dezentralen Artikels in Tagen\n            Erweiterung für Projekt AIS2005',
	MUTTER_EK_ID NUMBER(38,0) COMMENT 'Bei einer Serie von Artikeln mit gleichen Einkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_GP_ZU_PER primary key (DAT_VON, MANDANT_ID, ART_ID)
)COMMENT='TP2 AIS - Gibt an, welcher Lieferant zu einem Zeitpunkt für einen Artikel_2 gueltig ist'
;
