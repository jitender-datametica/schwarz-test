--==============================================================
-- Table: art_umrechnung_faktor_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umrechnung_faktor_per_1
   generated from Powerdesigner on Montag, 27. Januar 2025 17:12:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_UMRECHNUNG_FAKTOR_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   altnv_menge_einh_id                 VARCHAR(3)       NOT NULL COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_1 und Artikel_1 eine_1 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.',
   bruttogew                           NUMBER(29,3)     NOT NULL COMMENT 'Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew',
   umrech_faktor                       NUMBER(38,22)   NOT NULL COMMENT 'Umrechnungsfaktor für eine_1 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.',
   gew_einh_id                         VARCHAR(3)       NOT NULL COMMENT 'Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.',
   laenge                              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Länge (Tiefe) in cm aus laeng',
   breite                              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Breite in cm aus breit',
   hoehe                               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Höhe in cm aus hoehe',
   umrech_zaehler                      INTEGER     COMMENT 'Zähler für die Umrechnung in Basismengeneinheiten',
   umrech_nenner                       INTEGER     COMMENT 'Nenner für die Umrechnung in Basismengeneinheiten',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_UMRECHNUNG_FAKTOR_PER PRIMARY KEY (mandant_id, altnv_menge_einh_id, art_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die Umrechnungsfaktoren in die alternative Lagereinheit für die einzelnen Artikel_1 hinterlegt - MULTISET';
