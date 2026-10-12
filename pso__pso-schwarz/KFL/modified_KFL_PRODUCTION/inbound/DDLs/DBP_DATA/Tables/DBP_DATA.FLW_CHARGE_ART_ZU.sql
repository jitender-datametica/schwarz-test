--==============================================================
-- Table: flw_charge_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_art_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_CHARGE_ART_ZU (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   charge_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Charge aus charg',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   objekt_schluessel_id                VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Schlüssel des zu klassifizierenden Objektes aus dbp_data.flw_art ; flw_art_nr und dbp_data.flw_charge_art_zu ; charge_id - DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_CHARGE_ART_ZU PRIMARY KEY (flw_art_id, charge_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Chargenverwaltung aus mch1';

