create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_PM_VW_ZU_PER_2 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	PM_ID NUMBER(38,0) NOT NULL COMMENT 'Preismodul, Wert von 1 bis 10',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebsweges',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PREISTYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Preistyps',
	DAT_BIS DATE NOT NULL COMMENT 'Ende des Gueltigkeitszeitraums',
	DAT_VON DATE COMMENT 'Beginn des Gueltigkeitszeitraums',
	VK_BRUTTO NUMBER(9,3) COMMENT 'Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	constraint PK_ART_PM_VW_ZU_PER primary key (ART_ID, PM_ID, VW_ID, MANDANT_ID, PREISTYP_ID, DAT_BIS)
)COMMENT='TP2 AIS - Zuordnung der Artikel_2 zu Preismodul, Vertriebsweg und Preistyp - MULTISET\n             Enthaelt Informationen, wie Verkaufspreise je Preiskategorie zum Artikel_2 und Vertriebsweg zugeordnet sind.'
;
