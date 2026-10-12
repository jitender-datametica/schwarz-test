create or replace TABLE KFL_PRODUCTION.DBP_DATA.EK_INFOSATZ_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	EK_INFOSATZ_ID NUMBER(18,0) NOT NULL COMMENT 'Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel',
	ART_ID NUMBER(38,0) NOT NULL COMMENT ' Artikel_1 - Id',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschaeftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
	DAT_ERSTELLUNG DATE NOT NULL COMMENT 'Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum',
	GP_ART_ID VARCHAR(40) COLLATE 'en-ci' COMMENT 'Lieferanten-Artikelnummer',
	DAT_VON DATE NOT NULL COMMENT 'Lieferbar / gueltig-ab',
	DAT_BIS DATE NOT NULL COMMENT 'Lieferbar / gueltig-bis',
	REGEL_GP_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für Regellieferanten',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Flag geloescht',
	GP_TEILSORTIMENT_ID VARCHAR(10) COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
	KONDITIONSGRUPPE_ID VARCHAR(10) COMMENT 'Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.',
	MENGE_EINH_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Bestellmengeneinheit - nur gefüllt für DE (EINA_1 PR1), leer für KMO',
	APOLLO_IAN VARCHAR(35) COMMENT 'EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	CROSSDOCKING_ID NUMBER(38,0) COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.',
	constraint PK_EK_INFOSATZ primary key (MANDANT_ID, EK_INFOSATZ_ID)
)COMMENT='AIS_KMO- Artikel_1-Lieferantenzuordnung aus der SAP-Tabelle EINA. Wird im DWH vorlaeufig nur für KMO genutzt'
;