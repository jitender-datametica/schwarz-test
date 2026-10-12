CREATE OR REPLACE TABLE kfl_production_dbp_data.handling_unit_1 (
mandant_id INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
system_id INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle. der Marktnummer die Nebenbetriebskennziffer.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
handling_unit_id INTEGER NOT NULL OPTIONS(description='Interne Handling Unit_1 Nummer.'),
packmittel_typ STRING(1) COLLATE 'und:ci' OPTIONS(description='Packmitteltyp.'),
hu_gew_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Gewichtseinheit.'),
hu_vol_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Volumeneinheit.'),
lagernummer_id STRING(3) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie.'),
packmittelart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Packmittelart.'),
mat_gru_packmittel STRING(4) COLLATE 'und:ci' OPTIONS(description='Materialgruppe Packmittel.'),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
gewicht_ladung NUMERIC(9,3) OPTIONS(description='Ladungsgewicht der Handling Unit.'),
gewicht_eigen NUMERIC(9,3) OPTIONS(description='Eigengewicht der Handling Unit.'),
vol_ladung NUMERIC(18,3) OPTIONS(description='Ladungsvolumen der Handling Unit.'),
vol_eigen NUMERIC(18,3) OPTIONS(description='Eigenvolumen der Handling Unit.'),
versandeinheit_id INTEGER NOT NULL
OPTIONS(description='Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege. Referenziert auf vekp.vpobjkey.'),
anzahl_stellplatz NUMERIC(9,2) NOT NULL OPTIONS(description='Anzahl der für die Handling Unit_1 benötigten Stellplätze.'),
menge_gefahrgut NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gefahrgutmenge aus dem Feld zlvgefmenge_nve. Einheit ist immer in Litern.'),
brtvol_ladung NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist btvol.'),
brtgew_ladung NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttogewicht der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist brgew.'),
menge_handling_kolli_orig NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Kollimenge aus dem Feld zlv_kolli.'),
hu_status_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Bewegungsstatus der Handling Unit.'),
hu_stellplatz_faktor NUMERIC(9,2) OPTIONS(description='ID Bewegungsstatus der Handling Unit.'),
brtvol_ladung_gedeckelt NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden (Deckelung des Volumens der einzelnen HU auf max. 2304 cdm). Quelle ist btvol.'),
kj_lief_beleg INTEGER OPTIONS(description='Kalenderjahr Format JJJJ.'),
gewicht_gesamt NUMERIC(9,3) OPTIONS(description='Gesamtgewicht der Handling Unit.'),
handle STRING(22) OPTIONS(description='Weltweit eindeutiger Schlüssel für VEKP-VENUM.'),
handling_unit_id_parent INTEGER OPTIONS(description='Übergeordnete Handling Unit.'),
handling_unit_idart_ext STRING(1) OPTIONS(description='Art_1 der externen Handling Unit_1 Identifiaktion.'),
verpack_beleg_typ_id STRING(2) OPTIONS(description='Verpackungsobjekt.'),
vol_gesamt NUMERIC(18,3) OPTIONS(description='Gesamtvolumen der Handling Unit.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
dat_erstellung DATE OPTIONS(description='Erstellungsdatum (ERDAT) aus Quelltabelle VEKP.'),
dat_aenderung DATE OPTIONS(description='Letztes Änderungsdatum (AEDAT) aus Quelltabelle VEKP.'),
PRIMARY KEY (mandant_id, system_id, nb_id, wup_id, handling_unit_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS Kopftabelle der Handling-Unit. Quelle ist in SAP die Tabelle VEKP.');