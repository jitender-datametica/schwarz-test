--==============================================================
-- Table: cross_docking_avis_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cross_docking_avis_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CROSS_DOCKING_AVIS_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   cd_beleg_id                         INTEGER     NOT NULL,
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   cd_typ_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des CD-Belegs, z.Bsp. 2 ist CD Fleischwerk. Quelle ist zzlvcd',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   kunde_id                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Warenempfaenger (entspricht einer Marktnummermit führenden Nullen) Quelle ist zzlvcdwenum',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll.Quelle ist lfdat',
   handling_unit_id_ext                VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Original Nummer der Versandeinheit (NVE) Quelle ist zzlvcdnve',
   lief_beleg_ext_id                   VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Externe Identifikation des Lieferscheins aus lifex',
   cd_status_id                        INTEGER     COMMENT 'CD Status_2 aus zzlvcdstatv- in den Daten kommt 1 oder 2 vor. Bedeutung nicht klar',
   mandant_id_kunde                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Der Kunde kann zu einem anderen Mandanten als der WUP_2 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CROSS_DOCKING_AVIS PRIMARY KEY (mandant_id, cd_beleg_id, wup_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Cross Docking Belege aus der Quelle zlvcdavis';
