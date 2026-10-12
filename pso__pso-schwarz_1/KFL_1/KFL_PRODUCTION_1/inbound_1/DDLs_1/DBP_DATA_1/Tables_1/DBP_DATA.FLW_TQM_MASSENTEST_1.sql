--==============================================================
-- Table: flw_tqm_massentest_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_tqm_massentest_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TQM_MASSENTEST_1 (
   flw_lief_id                         NUMBER(38,0)     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   dat_test                            DATE             NOT NULL COMMENT 'Datum des Tests',
   pc_id                               VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Profitcenter',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   anz_stck_geprueft                   NUMBER(38,0)     NOT NULL COMMENT 'geprüfte Stückzahl',
   anz_kf_fehler                       NUMBER(38,0)     NOT NULL COMMENT 'Anzahl kritische Fehler',
   anz_vk_fehler                       NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Verkaufs-Fehler',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TQM_MASSENTEST PRIMARY KEY (flw_lief_id, mandant_id, flw_art_id, dat_test, pc_id, krk_id) NOT ENFORCED
)  COMMENT = 'FLW - im Fleischwerk erfasste Daten, die via HFM ins DWH übertragen werden';

