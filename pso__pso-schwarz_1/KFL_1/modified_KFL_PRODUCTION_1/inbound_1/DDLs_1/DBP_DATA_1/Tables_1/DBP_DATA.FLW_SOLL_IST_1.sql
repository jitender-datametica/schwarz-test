--==============================================================
-- Table: flw_soll_ist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_soll_ist_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SOLL_IST_1 (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   charge_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Charge aus charg',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_soll_ist                        DATE             NOT NULL COMMENT 'Datum',
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr. Compress blank',
   wechsel_id                          INTEGER     NOT NULL COMMENT 'Die Wechsel ID wird als fortlaufende Nummer vonMyMeat erzeugt, z.Bsp. bei Wechsel der Tierart oder des Lieferanten im WE',
   flw_lief_id                         INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   menge_bme                           NUMBER(29,3)     NOT NULL COMMENT 'Menge in Basismengeneinheiten aus menge',
   menge_dme                           NUMBER(29,3)     NOT NULL COMMENT 'Menge in doppelter Mengeneinheit aus dmeng',
   dme_einh_id                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'doppelte Mengeneinheit aus dmein',
   basismenge_einh_id                  VARCHAR(3)       COLLATE 'en-ci' COMMENT 'ID der Internationalen Maßeinheit aus msehi',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Bestellbeleg aus ebeln',
   betrag_soll_ist                     NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Vorschlagswert aus price',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   trennprozess_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL',
   schnittliste_id                     INTEGER     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr. Referenz zu flw_schnittliste_1',
   input_material_typ_id               VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des inputmaterials aus itypm. Z.Bsp. I = Input (Zukauf), A = Eingang (Vorstufe), N = Gesamt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SOLL_IST PRIMARY KEY (flw_art_id, charge_id, werk_id, dat_soll_ist, auftrag_id, wechsel_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Z-Tabelle zur Soll/ Istermittlung im Fleischwerk aus zfw_soll_ist';

