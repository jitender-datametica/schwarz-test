--==============================================================
-- Table: aktion_art_aktion_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_aktion_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_ART_AKTION_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kl_art_id                           INTEGER     NOT NULL COMMENT 'Kaufland Artikelnummer',
   plan_aktion_id                      VARCHAR(20)      NOT NULL COMMENT 'Vorläufige ID einer zukünftigen Aktion. Wird bei endgültiger Anlage im System in die sap_aktion_id geändert',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_ART_AKTION_ZU PRIMARY KEY (mandant_id, kl_art_id, plan_aktion_id) NOT ENFORCED
)  COMMENT = 'AIS - Aktionsartikeln wird eine Referenzaktion zugeordnet. Damit kann die Ermittlung der Aktionsmenge unterstützt werden';

