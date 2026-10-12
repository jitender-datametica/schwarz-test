CREATE OR REPLACE VIEW kfl_production_dbp_view.v_protokoll_verladung_ewm_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), transportation_unit_id
OPTIONS(description='Nummer eines Transportes im EWM-System. Ein Transport / eine_2 Tour_2 ist eine_2 Fahrt einer Transporters mit Start- und Zielverteilzentrum inklusive Zwischenstopps bei anderen VZs. Das Feld hat die gleiche Bedeutung wie tour_id, wurde aber von SAP abgeaendert.'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Warenannahme- und Versandaktivitaetsnummer der Transporteinheit.'), handling_unit_id_ext
OPTIONS(description='Externe Handling-Unit_2-Identifikation. Nummer der Palette.'), datzeit_scan
OPTIONS(description='Datum- und Zeitstempel der Bearbeitung. UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun).'),
lagernummer_id OPTIONS(description='ID der Lagernummer - hoechste Ebene der Lagerhierarchie.'), lagersortiment_id
OPTIONS(description='Lagersortiment ID.'), kunde_id OPTIONS(description='Warenempfaenger (wup_id_markt, Marktnummer).'),
dat_scan OPTIONS(description='Scandatum.'), zeit_scan OPTIONS(description='Scanuhrzeit.'), versandeinheit_id_ext
OPTIONS(description='Handling-Unit_2-ID bei Sammelpalette, wenn Paletten vereinigt werden. Enthaelt 18-stellige Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'),
lief_beleg_id
OPTIONS(description='Das Feld enthaelt die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
dat_lief_soll
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann fuer den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.'),
z_arbeitsgebiet_id
OPTIONS(description='Nachrichtentyp einer Pruefung bei einer Verladung. Ordnet die Pruef ID einem Typ/Arbeitsgebiet zu, in dem die Pruefung stattfindet. Ohne diese ID ist die pruef_id nicht eindeutig.'),
pruef_id OPTIONS(description='Nachrichtennummer die den Prueffall beschreibt.'), gesamtgewicht_hu
OPTIONS(description='Gesamtgewicht der Palette / Handling-Unit.'))
OPTIONS(DESCRIPTION = `ZGI_LOAD_RECORD ''PROTOKOLLTABELLE VERLADUNG'', QUELLE SAP-EWM. DIE TABELLE PROTOKOLL_VERLADUNG_2 AUS QUELLE SAP-LES BILDET DEN GLEICHEN SACHVERHALT AB, NUR IN ETWAS ANDERER FORM / ANDERER GRANULARITAET. SAP HAT IHR DATENMODELL VERAENDERT, WESHALBT SICH FELDNAMEN UND Z.T. AUCH BEDEUTUNG UNTERSCHEIDEN. AUCH WERDEN HIER EINIGE FEHLER DER ANDEREN TABELLE BEHOBEN.`)
AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 handling_unit_id_ext,
 datzeit_scan,
 lagernummer_id,
 lagersortiment_id,
 kunde_id,
 dat_scan,
 zeit_scan,
 versandeinheit_id_ext,
 lief_beleg_id,
 dat_lief_soll,
 z_arbeitsgebiet_id,
 pruef_id,
 gesamtgewicht_hu
FROM kfl_production_dbp_data.protokoll_verladung_ewm_2;