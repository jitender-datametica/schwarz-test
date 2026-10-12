--==============================================================
-- Table: handling_unit_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_2
   generated from Powerdesigner on Montag, 26. September 2022 14:27:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle. der Marktnummer die Nebenbetriebskennziffer.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
handling_unit_id INTEGER NOT NULL OPTIONS(description='Interne Handling Unit_2 Nummer.'),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_2 Gruppe_2 von Laderampen) oder um eine_2 logische Gruppierung (z.B. eine_2 Gruppe_2 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
versandeinheit_id INTEGER NOT NULL
OPTIONS(description='Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
handling_unit_id_parent INTEGER OPTIONS(description='Übergeordnete Handling Unit.'),
handling_unit_idart_ext STRING(1) OPTIONS(description='Art_2 der externen Handling Unit_2 Identifiaktion.'),
gewicht_gesamt NUMERIC(9,3) OPTIONS(description='Gesamtgewicht der Handling Unit.'),
gewicht_ladung NUMERIC(9,3) OPTIONS(description='Ladungsgewicht der Handling Unit.'),
gewicht_eigen NUMERIC(9,3) OPTIONS(description='Eigengewicht der Handling Unit.'),
hu_gew_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Gewichtseinheit.'),
vol_gesamt NUMERIC(18,3) OPTIONS(description='Gesamtvolumen der Handling Unit.'),
vol_ladung NUMERIC(18,3) OPTIONS(description='Ladungsvolumen der Handling Unit.'),
vol_eigen NUMERIC(18,3) OPTIONS(description='Eigenvolumen der Handling Unit.'),
hu_vol_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Volumeneinheit.'),
verpack_beleg_typ_id STRING(2) OPTIONS(description='Verpackungsobjekt.'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege. Referenziert auf vekp.vpobjkey.'),
kj_lief_beleg BIGNUMERIC(38,0) OPTIONS(description='Kalenderjahr Format JJJJ.'),
lagernummer_id STRING(3) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie.'),
hu_status_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Bewegungsstatus der Handling Unit.'),
packmittel_typ STRING(1) COLLATE 'und:ci' OPTIONS(description='Packmitteltyp.'),
packmittelart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Packmittelart.'),
mat_gru_packmittel STRING(4) COLLATE 'und:ci' OPTIONS(description='Materialgruppe Packmittel.'),
anzahl_stellplatz NUMERIC(9,2) NOT NULL OPTIONS(description='Anzahl der für die Handling Unit_2 benötigten Stellplätze.'),
hu_stellplatz_faktor NUMERIC(9,2) OPTIONS(description='ID Bewegungsstatus der Handling Unit.'),
menge_handling_kolli_orig NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Kollimenge aus dem Feld zlv_kolli.'),
menge_gefahrgut NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gefahrgutmenge aus dem Feld zlvgefmenge_nve. Einheit ist immer in Litern.'),
brtvol_ladung NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist btvol.'),
brtvol_ladung_gedeckelt NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden (Deckelung des Volumens der einzelnen HU auf max. 2304 cdm). Quelle ist btvol.'),
brtgew_ladung NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttogewicht der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist brgew.'),
handle STRING(22) OPTIONS(description='Weltweit eindeutiger Schlüssel für VEKP-VENUM.'),
dat_erstellung DATE OPTIONS(description='Erstellungsdatum (ERDAT) aus Quelltabelle VEKP.'),
dat_aenderung DATE OPTIONS(description='Letztes Änderungsdatum (AEDAT) aus Quelltabelle VEKP.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, nb_id, wup_id, handling_unit_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS Kopftabelle der Handling-Unit. Quelle ist in SAP die Tabelle VEKP.');