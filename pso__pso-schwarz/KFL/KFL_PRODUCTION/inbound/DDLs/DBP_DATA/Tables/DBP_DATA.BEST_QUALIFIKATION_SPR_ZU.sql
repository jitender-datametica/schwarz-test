--==============================================================
-- Table: best_qualifikation_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_qualifikation_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_QUALIFIKATION_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   best_qualifikation_id               VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Identifiziert eindeutig einen spezifischen Lagerbestand eines Materials, z. B. Qualitätsprüfbestand, Retourenbestand, usw.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   best_qualifikation_bez              VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Dieses Feld enthält die Kurzbezeichnung der Bestandsqualifikationen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_QUALIFIKATION_SPR_ZU PRIMARY KEY (mandant_id, best_qualifikation_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle befinden die sprachabhängigen Kurztexte für die Qulifikation der Lagerbestände. - MULTISET';

