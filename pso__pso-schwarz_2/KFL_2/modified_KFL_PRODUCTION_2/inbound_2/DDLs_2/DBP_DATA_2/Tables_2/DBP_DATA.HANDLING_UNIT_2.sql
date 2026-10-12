--==============================================================
-- Table: handling_unit_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_2
   generated from Powerdesigner on Montag, 26. September 2022 14:27:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HANDLING_UNIT_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   system_id                           INTEGER    NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle. der Marktnummer die Nebenbetriebskennziffer.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   handling_unit_id                    INTEGER    NOT NULL COMMENT 'Interne Handling Unit_2 Nummer.',
   versandstelle_id                    VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_2 Gruppe_2 von Laderampen) oder um eine_2 logische Gruppierung (z.B. eine_2 Gruppe_2 von Personen, die für die Versandaktivitäten zuständig ist) handeln.',
   versandeinheit_id                   INTEGER    NOT NULL COMMENT 'Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.',
   handling_unit_id_ext                VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE).',
   handling_unit_id_parent             INTEGER    COMMENT 'Übergeordnete Handling Unit.',
   handling_unit_idart_ext             VARCHAR(1)      COMMENT 'Art_2 der externen Handling Unit_2 Identifiaktion.',
   gewicht_gesamt                      NUMBER(29,3)     COMMENT 'Gesamtgewicht der Handling Unit.',
   gewicht_ladung                      NUMBER(29,3)     COMMENT 'Ladungsgewicht der Handling Unit.',
   gewicht_eigen                       NUMBER(29,3)     COMMENT 'Eigengewicht der Handling Unit.',
   hu_gew_einh_id                      VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Gewichtseinheit.',
   vol_gesamt                          NUMBER(29,3)    COMMENT 'Gesamtvolumen der Handling Unit.',
   vol_ladung                          NUMBER(29,3)    COMMENT 'Ladungsvolumen der Handling Unit.',
   vol_eigen                           NUMBER(29,3)    COMMENT 'Eigenvolumen der Handling Unit.',
   hu_vol_einh_id                      VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Volumeneinheit.',
   verpack_beleg_typ_id                VARCHAR(2)      COMMENT 'Verpackungsobjekt.',
   lief_beleg_id                       INTEGER    NOT NULL COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege. Referenziert auf vekp.vpobjkey.',
   kj_lief_beleg                       INTEGER    COMMENT 'Kalenderjahr Format JJJJ.',
   lagernummer_id                      VARCHAR(3)      COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie.',
   hu_status_id                        VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Bewegungsstatus der Handling Unit.',
   packmittel_typ                      VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Packmitteltyp.',
   packmittelart_id                    VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Packmittelart.',
   mat_gru_packmittel                  VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Materialgruppe Packmittel.',
   anzahl_stellplatz                   NUMBER(29,2)     NOT NULL COMMENT 'Anzahl der für die Handling Unit_2 benötigten Stellplätze.',
   hu_stellplatz_faktor                NUMBER(29,2)     COMMENT 'ID Bewegungsstatus der Handling Unit.',
   menge_handling_kolli_orig           NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Kollimenge aus dem Feld zlv_kolli.',
   menge_gefahrgut                     NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Gefahrgutmenge aus dem Feld zlvgefmenge_nve. Einheit ist immer in Litern.',
   brtvol_ladung                       NUMBER(29,3)    NOT NULL COMMENT 'Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist btvol.',
   brtvol_ladung_gedeckelt             NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Das Bruttovolumen der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden (Deckelung des Volumens der einzelnen HU auf max. 2304 cdm). Quelle ist btvol.',
   brtgew_ladung                       NUMBER(29,3)    NOT NULL COMMENT 'Das Bruttogewicht der Ladung. kann wegen mangelnder Datenqualität nicht aus Netto + Tara ermittelt werden. Quelle ist brgew.',
   handle                              VARCHAR(22)     COMMENT 'Weltweit eindeutiger Schlüssel für VEKP-VENUM.',
   dat_erstellung                      DATE            COMMENT 'Erstellungsdatum (ERDAT) aus Quelltabelle VEKP.',
   dat_aenderung                       DATE            COMMENT 'Letztes Änderungsdatum (AEDAT) aus Quelltabelle VEKP.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HANDLING_UNIT PRIMARY KEY (mandant_id, versandstelle_id, system_id, nb_id, wup_id, handling_unit_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS Kopftabelle der Handling-Unit. Quelle ist in SAP die Tabelle VEKP.';
