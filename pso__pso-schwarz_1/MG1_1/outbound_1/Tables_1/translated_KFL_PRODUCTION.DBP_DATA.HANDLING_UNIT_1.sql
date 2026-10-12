CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.HANDLING_UNIT_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle. der Marktnummer die Nebenbetriebskennziffer.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
HANDLING_UNIT_ID INTEGER NOT NULL OPTIONS(description='Interne Handling Unit_1 Nummer.'),
PACKMITTEL_TYP STRING(1) COLLATE 'und:ci' OPTIONS(description='Packmitteltyp.'),
HU_GEW_EINH_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Gewichtseinheit.'),
HU_VOL_EINH_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Volumeneinheit.'),
LAGERNUMMER_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie.'),
PACKMITTELART_ID STRING(4) COLLATE 'und:ci' OPTIONS(description='Packmittelart.'),
MAT_GRU_PACKMITTEL STRING(4) COLLATE 'und:ci' OPTIONS(description='Materialgruppe Packmittel.'),
VERSANDSTELLE_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
GEWICHT_LADUNG NUMERIC(9,3) OPTIONS(description='Ladungsgewicht der Handling Unit.'),
GEWICHT_EIGEN NUMERIC(9,3) OPTIONS(description='Eigengewicht der Handling Unit.'),
VOL_LADUNG NUMERIC(18,3) OPTIONS(description='Ladungsvolumen der Handling Unit.'),
VOL_EIGEN NUMERIC(18,3) OPTIONS(description='Eigenvolumen der Handling Unit.'),
VERSANDEINHEIT_ID INTEGER NOT NULL
OPTIONS(description='Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'),
HANDLING_UNIT_ID_EXT STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
LIEF_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege. Referenziert auf vekp.vpobjkey.'),
ANZAHL_STELLPLATZ NUMERIC(9,2) NOT NULL OPTIONS(description='Anzahl der für die Handling Unit_1 benötigten Stellplätze.'),
MENGE_GEFAHRGUT NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gefahrgutmenge aus dem Feld zlvgefmenge_nve. Einheit ist immer in Litern.'),
BRTVOL_LADUNG NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist btvol.'),
BRTGEW_LADUNG NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Bruttogewicht der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist brgew.'),
MENGE_HANDLING_KOLLI_ORIG NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Kollimenge aus dem Feld zlv_kolli.'),
HU_STATUS_ID STRING(4) COLLATE 'und:ci' OPTIONS(description='Bewegungsstatus der Handling Unit.'),
HU_STELLPLATZ_FAKTOR NUMERIC(9,2) OPTIONS(description='ID Bewegungsstatus der Handling Unit.'),
BRTVOL_LADUNG_GEDECKELT NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden (Deckelung des Volumens der einzelnen HU auf max. 2304 cdm). Quelle ist btvol.'),
KJ_LIEF_BELEG INTEGER OPTIONS(description='Kalenderjahr Format JJJJ.'),
GEWICHT_GESAMT NUMERIC(9,3) OPTIONS(description='Gesamtgewicht der Handling Unit.'),
HANDLE STRING(22) OPTIONS(description='Weltweit eindeutiger Schlüssel für VEKP-VENUM.'),
HANDLING_UNIT_ID_PARENT INTEGER OPTIONS(description='Übergeordnete Handling Unit.'),
HANDLING_UNIT_IDART_EXT STRING(1) OPTIONS(description='Art_1 der externen Handling Unit_1 Identifiaktion.'),
VERPACK_BELEG_TYP_ID STRING(2) OPTIONS(description='Verpackungsobjekt.'),
VOL_GESAMT NUMERIC(18,3) OPTIONS(description='Gesamtvolumen der Handling Unit.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
DAT_ERSTELLUNG DATE OPTIONS(description='Erstellungsdatum (ERDAT) aus Quelltabelle VEKP.'),
DAT_AENDERUNG DATE OPTIONS(description='Letztes Änderungsdatum (AEDAT) aus Quelltabelle VEKP.'),
PRIMARY KEY (MANDANT_ID, SYSTEM_ID, NB_ID, WUP_ID, HANDLING_UNIT_ID) NOT ENFORCED
) OPTIONS(description='TP408_LVS Kopftabelle der Handling-Unit. Quelle ist in SAP die Tabelle VEKP.');