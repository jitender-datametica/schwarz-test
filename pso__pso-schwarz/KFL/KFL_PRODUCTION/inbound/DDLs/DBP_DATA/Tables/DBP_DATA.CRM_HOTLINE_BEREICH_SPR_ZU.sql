--==============================================================
-- Table: crm_hotline_bereich_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_hotline_bereich_spr_zu
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_HOTLINE_BEREICH_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   crm_hotline_bereich_id              NUMBER(38,0)     NOT NULL COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   crm_hotline_bereich_bez             VARCHAR(200)     COMMENT 'Bezeichnung des Bereichs innerhalb der CRM-Hotline.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_HOTLINE_BEREICH_SPR_ZU PRIMARY KEY (mandant_id, crm_hotline_bereich_id, spr_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle enthält die sprachabhängigen Bezeichnungen der CRM-Hotline-Bereiche. Sie wird manuell befüllt.';
