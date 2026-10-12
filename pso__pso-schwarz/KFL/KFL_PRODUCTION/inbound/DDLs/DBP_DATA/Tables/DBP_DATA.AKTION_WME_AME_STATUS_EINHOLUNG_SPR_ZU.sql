--==============================================================
-- Table: aktion_wme_ame_status_einholung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_wme_ame_status_einholung_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_WME_AME_STATUS_EINHOLUNG_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   status_einholung_id                 NUMBER(38,0)     NOT NULL COMMENT 'ID Status der Einholung',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'DWH Sprach ID ',
   status_einholung_bez                VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung Status der Einholung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_WME_AME_STATUS_EINHOLUNG_SPR_ZU PRIMARY KEY (mandant_id, status_einholung_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen zum Status Einholung der Werbemengen / Allg. Mengeneinholung - manuelle Beladung';

