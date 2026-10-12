--==============================================================
-- Table: flw_herkunft_verfolgung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_herkunft_verfolgung
   generated from Powerdesigner on Freitag, 12. April 2024 11:53:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HERKUNFT_VERFOLGUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk, aus werks. - Quelle - lookup der Werk-Id für WERKS',
   aenderung_id                        INTEGER     NOT NULL COMMENT 'Aenderungsgeschichte ID in der Quelle, eine eindeutige Nummer die genau diesen einen Datensatz behandelt. - Quelle - CHGID',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Datum und Uhrzeit an dem der Satz im System erstellt wurde. - Quelle - ERDAT und ERZET',
   dat_produktion                      DATE             NOT NULL COMMENT 'Datum an dem die Produktion stattgefunden hat. - Quelle - ZDPS_PROD_DATE',
   alt_identifikation_id               VARCHAR(10)      COMMENT 'Die Identifikationsnummer stellt eine Gruppierung von Material nach Anlieferung, ES-/ EZ-Nummer, Kategorie und Herkunft (Land) dar.
            Sie dient dazu eine Vermischung von Herkunft nach Land und/oder ES-/ EZ-Nummer zu verhindern/nachzuverfolgen.
            ES-/EZ-Nummer ist hierbei die Europäische Schlachtbetriebsnummer/Schlachthofnummer ist eine europäische Zulassungsnummer für jeden Betrieb bzw. Werk.
            Es gibt Fälle, die nicht identifikationspflichtig sind da nur bei Rind vorgeschrieben, in diesen Fall können die Identifikationsnummern leer sein.
            Identifikationsnummer basierend auf Anlieferung, Herkunft, Es/Ez-Nummer (europäische Schlachtbetriebsnummer/ Zerlegebetriebsnummer) und Kategorie (z.B. keine Ausprägung, Jungbulle, Rind, Färse).
            Die Identifikationsnummer ist eine Eigenschaft der Charge und kann für mehrere Chargen gleich sein. - Quelle - WEID_OLD',
   neu_identifikation_id               VARCHAR(10)      COMMENT 'Die Identifikationsnummer stellt eine Gruppierung von Material nach Anlieferung, ES-/ EZ-Nummer, Kategorie und Herkunft (Land) dar.
            Sie dient dazu eine Vermischung von Herkunft nach Land und/oder ES-/ EZ-Nummer zu verhindern/nachzuverfolgen.
            ES-/EZ-Nummer ist hierbei die Europäische Schlachtbetriebsnummer/Schlachthofnummer ist eine europäische Zulassungsnummer für jeden Betrieb bzw. Werk.
            Es gibt Fälle die nicht identifikationspflichtig sind da nur bei Rind vorgeschrieben, in diesen Fall können die Identifikationsnummern leer sein.
            Identifikationsnummer basierend auf Anlieferung, Herkunft, Es/Ez-Nummer (europäische Schlachtbetriebsnummer/ Zerlegebetriebsnummer) und Kategorie (z.B. keine Ausprägung, Jungbulle, Rind, Färse).
            Die Identifikationsnummer ist eine Eigenschaft der Charge und kann für mehrere Chargen gleich sein. - Quelle - WEID_NEW',
   alt_wechsel_id                      VARCHAR(9)       COMMENT 'Die Wechsel-Id dient zur räumlichen und zeitlichen Positionierung des über die Identifikationsnummer beschriebenen Materials im Verarbeitungsprozess.
            Für die Vergabe einer Wechsel-Id sind Faktoren wie Arbeitsplatz, Identifikationsnummer, EZ / ES-Nr., Länderherkunft, Tiergattung, Schlachtdatum ausschlaggebend.
            Die Wechsel-Id entsteht dabei am Ausgang eines Prozessschrittes in Folge eines Fertigungsauftrages, z.B. Zerlegung und Verteilung auf verschiedene Transporteinheiten (Palette, Haken, Box, Rauchwagen, usw.)
            Gründe für eine Wechsel-Id können etwa Wechsel des Arbeitsplatzes, die Transporteinheit(-en), die Auftragsnummer, der Wechsel des Identen am Stritt im Prozess, damit einhergehend möglicherweise ein anderes Schlachtdatum am Arbeitsplatz/ anderes Herkunftsland oder Wechsel der Gattung sein.
            Ist das Material nicht identifikationspflichtig, können beide Felder dafür leer sein. - Quelle - WCHID_OLD',
   neu_wechsel_id                      VARCHAR(9)       COMMENT 'Die Wechsel-Id dient zur räumlichen und zeitlichen Positionierung des über die Identifikationsnummer beschriebenen Materials im Verarbeitungsprozess.
            Für die Vergabe einer Wechsel-Id sind Faktoren wie Arbeitsplatz, Identifikationsnummer, EZ / ES-Nr., Länderherkunft, Tiergattung, Schlachtdatum ausschlaggebend.
            Die Wechsel-Id entsteht dabei am Ausgang eines Prozessschrittes in Folge eines Fertigungsauftrages, z.B. Zerlegung und Verteilung auf verschiedene Transporteinheiten (Palette, Haken, Box, Rauchwagen, usw.)
            Gründe für eine Wechsel-Id können etwa Wechsel des Arbeitsplatzes, die Transporteinheit(-en), die Auftragsnummer, der Wechsel des Identen am Stritt im Prozess, damit einhergehend möglicherweise ein anderes Schlachtdatum am Arbeitsplatz/ anderes Herkunftsland oder Wechsel der Gattung sein.
            Ist das Material nicht identifikationspflichtig, können beide Felder dafür leer sein. - Quelle - WCHID_NEW',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HERKUNFT_VERFOLGUNG PRIMARY KEY (mandant_id, werk_id, aenderung_id, datzeit_erstellung) NOT ENFORCED
)  COMMENT = 'Tabelle zur Verfolgung der Identifikationsnummern und Wechsel-IDs, über die Zeit, durch den Verarbeitungsprozess im Werk vom Wareneingang zum Warenausgang. - Quelle - ZFWMYM_CHGHIST';
