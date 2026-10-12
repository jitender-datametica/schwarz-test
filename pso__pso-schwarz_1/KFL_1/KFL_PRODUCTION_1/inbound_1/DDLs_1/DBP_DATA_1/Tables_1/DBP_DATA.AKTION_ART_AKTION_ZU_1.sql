--==============================================================
-- Table: aktion_art_aktion_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_aktion_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_ART_AKTION_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   kl_art_id                           NUMBER(38,0)     NOT NULL COMMENT 'Kaufland Artikelnummer',
   plan_aktion_id                      VARCHAR(20)      NOT NULL COMMENT 'Vorläufige ID einer zukünftigen Aktion. Wird bei endgültiger Anlage_1 im System in die sap_aktion_id geändert',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_ART_AKTION_ZU PRIMARY KEY (mandant_id, kl_art_id, plan_aktion_id) NOT ENFORCED
)  COMMENT = 'AIS - Aktionsartikeln wird eine_1 Referenzaktion zugeordnet. Damit kann die Ermittlung der Aktionsmenge unterstützt werden';

