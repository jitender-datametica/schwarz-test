--==============================================================
-- Table: aktion_wme_ame_status_einholung_markt_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_wme_ame_status_einholung_markt_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_WME_AME_STATUS_EINHOLUNG_MARKT_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   status_einholung_markt_kz           VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen Status_2 der Einholung im Markt',
   spr_id                              INTEGER     NOT NULL COMMENT 'DWH Sprach ID ',
   status_einholung_markt_bez          VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung Status_2 der Einholung im Markt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_WME_AME_STATUS_EINHOLUNG_MARKT_SPR_ZU PRIMARY KEY (mandant_id, status_einholung_markt_kz, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen zum Status_2 Einholung der Werbemengen / Allg. Mengeneinholung im Markt- manuelle Beladung';

