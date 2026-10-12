--==============================================================
-- Table: eps_containertyp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_CONTAINERTYP_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL,
   containertyp_id                     NUMBER(38,0)     NOT NULL COMMENT 'ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   spr_id                              NUMBER(38,0)     NOT NULL,
   containertyp_bez                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_CONTAINERTYP_SPR_ZU PRIMARY KEY (mandant_id, containertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung';

