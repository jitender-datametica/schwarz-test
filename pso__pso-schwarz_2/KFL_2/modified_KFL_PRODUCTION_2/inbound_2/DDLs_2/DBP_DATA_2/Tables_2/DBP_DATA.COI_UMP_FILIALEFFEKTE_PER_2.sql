--==============================================================
-- Table: coi_ump_filialeffekte_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_filialeffekte_per_2
   generated from Powerdesigner on Dienstag, 20. September 2022 17:25:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_FILIALEFFEKTE_PER_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   gj_plan                             INTEGER    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   version_id                          INTEGER    NOT NULL COMMENT 'Die Planversion eines Geschaeftsjahres (1-9)',
   land_level                          VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Kueste und HRL für Kroatien Land_2',
   wup_id                              INTEGER    NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   filialeffekt_massnahme_typ          VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Von COI vorgegebene Effekte (Kannibalisierung, Wettbewerb, Infrastruktur, Vertrieb)',
   filialeffekt_auswirkung_bez         VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Beschreibung der Auswirkung (Freitext). Auswirkungen koennen sich zeitlich ueberschneiden.',
   dat_filialeffekt_von                DATE            NOT NULL COMMENT 'Beginn des Effekt, der sich auf den Filialumsatz auswirkt',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   massnahme_id                        INTEGER    NOT NULL COMMENT 'Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird',
   dat_filialeffekt_bis                DATE            COMMENT 'Ende des Effekt, der sich auf den Filialumsatz auswirkt',
   faktor_filialeffekt                 NUMBER(38,10)   COMMENT 'Faktor in % für Filialeffekte, die Auswirkung auf den Umsatz haben. Auswirkungen koennen sich zeitlich ueberschneiden. (entweder faktor_... in % oder wert_... Spalte wird gefuellt)',
   wert_filialeffekt                   NUMBER(29,4)    COMMENT 'Absolutwert (für den kompletten Gueltigkeitszeitraum) für Filialeffekte, die Auswirkung auf den Umsatz haben. (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)',
   umsatz_netto_massnahme_ges          NUMBER(29,4)    COMMENT 'Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 fuer die angegebene Zeitperiode über die angegebene hwg Beschraenkung',
   bereinigt_fg                        INTEGER    DEFAULT 0 COMMENT 'Das FG gibt an, ob eine_2 Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_FILIALEFFEKTE_PER PRIMARY KEY (mandant_id, gj_plan, version_id, land_level, wup_id, nb_id, filialeffekt_massnahme_typ, filialeffekt_auswirkung_bez, dat_filialeffekt_von) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Pflege der Filialeffekte pro Filiale und deren Auswirkung auf den Umsatz - Planversion abhaengig - manueller Upload';
