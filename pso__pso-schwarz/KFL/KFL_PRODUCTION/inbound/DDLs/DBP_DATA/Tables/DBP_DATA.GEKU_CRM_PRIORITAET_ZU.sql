--==============================================================
-- Table: geku_crm_prioritaet_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_prioritaet_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_PRIORITAET_ZU (
   geku_crm_prioritaet_id              NUMBER(38,0)     NOT NULL COMMENT 'Mapping ID',
   crm_prioritaet_id                   NUMBER(38,0)     COMMENT 'ID der Priorität, niedrig, mittel, hoch',
   geku_prioritaet_id                  NUMBER(38,0)     COMMENT 'Prioritaet ID aus GEKU. FK wird in View aus l_geku_zusatzinfo_sel_zu (mit Join auf geku_zusatzinfo_spr_zu) gebildet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_PRIORITAET_ZU PRIMARY KEY (geku_crm_prioritaet_id) NOT ENFORCED
)  COMMENT = 'GEKU - Mapping Tabelle Priorität Geku zu CRM. In GEKU existiert keine Gegenparttabelle. FK wird in View aus l_geku_zusatzinfo_sel_zu (mit Join auf geku_zusatzinfo_spr_zu) gebildet';

