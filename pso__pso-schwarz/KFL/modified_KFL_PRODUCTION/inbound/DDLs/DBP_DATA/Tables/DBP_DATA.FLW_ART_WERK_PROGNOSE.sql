--==============================================================
-- Table: flw_art_werk_prognose
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_werk_prognose
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_WERK_PROGNOSE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   dat_lief                            DATE             NOT NULL COMMENT 'Lieferdatum aus lfdat',
   prognosetyp_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Prognosetyp aus prognose_typ.  M = Materialprognose, F = Filialprognose',
   dat_erstellung_von                  DATE             NOT NULL COMMENT 'Datum, an dem die Prognose im Industrie-System verarbeitet wurde aus erdatum',
   prognose_version                    INTEGER     NOT NULL COMMENT 'Prognose Version, von FUR vergeben',
   version_lfd_nr                      INTEGER     NOT NULL COMMENT 'Bei Änderungen der Prognose innerhalb FLW wird eine höhere Version erzeugt',
   dat_erstellung_bis                  DATE             NOT NULL COMMENT 'Feld wird im DWH angereichert. Ende des Zeitraums zwischen einem dat_erstellung und dem folgenden dat_erstellung',
   bestellmenge                        NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Bestellmenge aus bestmg',
   dat_bereitstellung                  DATE             NOT NULL COMMENT 'Fleischwerk Bereitstelldatum aus Liefertermin-DB aus berdatum',
   best_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Bestellmengeinheit aus bstme',
   frueh_spaet_kz                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichnet, ob der Markt früh oder spät beliefert wird aus fskz',
   bedarfsplan_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Quelle: bedarfsplannummer. Enthält char-Angaben wie z.Bsp. hawa, schwein, rind,...COMPRESS SCWEIN, RIND, HVO',
   flw_fg                              INTEGER     NOT NULL COMMENT 'Fleischwerk Flag. Ist = 1, wenn die Prognose für FLW relevant ist. Wird über prognose_version gefüllt. prognose_version beginnt für FLW mit 0, für FUR mit 1',
   menge_basis                         NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Basismengeneinheit aus basmg',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_WERK_PROGNOSE PRIMARY KEY (flw_art_id, werk_id, flw_kunde_id, dat_lief, prognosetyp_id, dat_erstellung_von, prognose_version, version_lfd_nr, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Fleischwerk Absatzplanung (Prognosedaten) aus zfw_absatzplan - MULTISET';

