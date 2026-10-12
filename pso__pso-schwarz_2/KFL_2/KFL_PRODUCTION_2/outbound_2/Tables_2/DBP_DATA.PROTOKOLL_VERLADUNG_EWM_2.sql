--==============================================================
-- Table: protokoll_verladung_ewm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_verladung_ewm_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:36:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.protokoll_verladung_ewm_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer eines Transportes im EWM-System. Ein Transport / eine_2 Tour_2 ist eine_2 Fahrt einer Transporters mit Start- und Zielverteilzentrum inklusive Zwischenstopps bei anderen VZs. Das Feld hat die gleiche Bedeutung wie tour_id, wurde aber von SAP abgeaendert.'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenannahme- und Versandaktivitaetsnummer der Transporteinheit.'),
handling_unit_id_ext STRING(20) NOT NULL
OPTIONS(description='Externe Handling-Unit_2-Identifikation. Nummer der Palette.'),
datzeit_scan DATETIME NOT NULL
OPTIONS(description='Datum- und Zeitstempel der Bearbeitung. UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun).'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='ID der Lagernummer - hoechste Ebene der Lagerhierarchie.'),
lagersortiment_id STRING(1) OPTIONS(description='Lagersortiment ID.'),
kunde_id BIGNUMERIC(38,0) OPTIONS(description='Warenempfaenger (wup_id_markt, Marktnummer).'),
dat_scan DATE OPTIONS(description='Scandatum.'),
zeit_scan TIME OPTIONS(description='Scanuhrzeit.'),
versandeinheit_id_ext STRING(20)
OPTIONS(description='Handling-Unit_2-ID bei Sammelpalette, wenn Paletten vereinigt werden. Enthaelt 18-stellige Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'),
lief_beleg_id BIGNUMERIC(38,0)
OPTIONS(description='Das Feld enthaelt die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
dat_lief_soll DATE
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann fuer den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.'),
z_arbeitsgebiet_id BIGNUMERIC(38,0)
OPTIONS(description='Nachrichtentyp einer Pruefung bei einer Verladung. Ordnet die Pruef ID einem Typ/Arbeitsgebiet zu, in dem die Pruefung stattfindet. Ohne diese ID ist die pruef_id nicht eindeutig.'),
pruef_id BIGNUMERIC(38,0) OPTIONS(description='Nachrichtennummer die den Prueffall beschreibt.'),
gesamtgewicht_hu BIGNUMERIC(38,3) OPTIONS(description='Gesamtgewicht der Palette / Handling-Unit.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, transportation_unit_sr_act_id, kj_transportation_unit,
 handling_unit_id_ext, datzeit_scan, lagernummer_id) NOT ENFORCED
)
OPTIONS(description='ZGI_LOAD_RECORD\'Protokolltabelle Verladung\', Quelle SAP-EWM. Die Tabelle protokoll_verladung_2 aus Quelle SAP-LES bildet den gleichen Sachverhalt ab, nur in etwas anderer Form / anderer Granularitaet. SAP hat ihr Datenmodell veraendert, weshalbt sich Feldnamen und z.T. auch Bedeutung unterscheiden. Auch werden hier einige Fehler der anderen Tabelle behoben.');