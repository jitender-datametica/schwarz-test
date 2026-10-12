CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EK_INFOSATZ_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
EK_INFOSATZ_ID INTEGER NOT NULL
OPTIONS(description='Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel'),
ART_ID INTEGER NOT NULL OPTIONS(description=' Artikel_1 - Id'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschaeftspartner - ID (Lieferanten - ID)'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL
OPTIONS(description='Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
DAT_ERSTELLUNG DATE NOT NULL
OPTIONS(description='Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum'),
GP_ART_ID STRING(40) COLLATE 'und:ci' OPTIONS(description='Lieferanten-Artikelnummer'),
DAT_VON DATE NOT NULL OPTIONS(description='Lieferbar / gueltig-ab'),
DAT_BIS DATE NOT NULL OPTIONS(description='Lieferbar / gueltig-bis'),
REGEL_GP_FG INTEGER NOT NULL OPTIONS(description='Flag für Regellieferanten'),
LOESCH_FG INTEGER NOT NULL OPTIONS(description='Flag geloescht'),
GP_TEILSORTIMENT_ID STRING(10) COLLATE 'und:ci' OPTIONS(description='Teilsortiment aus SAP ltsnr'),
KONDITIONSGRUPPE_ID STRING(10) OPTIONS(description='Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.'),
MENGE_EINH_ID STRING(3) COLLATE 'und:ci'
OPTIONS(description='Bestellmengeneinheit - nur gefüllt für DE (EINA_1 PR1), leer für KMO'),
APOLLO_IAN STRING(35)
OPTIONS(description='EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
CROSSDOCKING_ID INTEGER OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'),
PRIMARY KEY (MANDANT_ID, EK_INFOSATZ_ID) NOT ENFORCED
)
OPTIONS(description='AIS_KMO- Artikel_1-Lieferantenzuordnung aus der SAP-Tabelle EINA. Wird im DWH vorlaeufig nur für KMO genutzt');