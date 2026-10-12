--==============================================================
-- Table: flw_qual_meldung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_qual_meldung
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_QUAL_MELDUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   qual_meldung_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID der Qualitätsmeldung aus qmnum',
   meldungsart_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Meldungsart aus qmart',
   flw_lief_id                         INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Bestellbeleg aus ebeln',
   zeit_pforte                         INTEGER     NOT NULL COMMENT 'Pfortenzeit. Wird aus qmtxt als String herausgelöst. Nullable, da nicht in allen Sätzen vorhanden',
   dat_erfasst                         DATE             NOT NULL COMMENT 'Erfassdatum aus erdat',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_QUAL_MELDUNG PRIMARY KEY (mandant_id, qual_meldung_id) NOT ENFORCED
)  COMMENT = 'FLW - Qualitätsmeldung aus qmel';

