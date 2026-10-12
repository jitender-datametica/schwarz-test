--==============================================================
-- Table: eps_layout_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_layout_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_LAYOUT_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL,
   layout_kz                           NUMBER(38,0)     NOT NULL COMMENT 'Redundant - Speziell für MSI - Kennzeichen des Layouts (Etikett, Plakat)',
   layout_bez                          VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Layouts (z.B. Etikett)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_LAYOUT_SPR_ZU PRIMARY KEY (mandant_id, spr_id, layout_kz) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen des Layouts aus EPS (z.B. Etikett) - manuelle Beladung';

