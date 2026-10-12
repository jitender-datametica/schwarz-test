--==============================================================
-- Table: eps_containertyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_CONTAINERTYP_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL,
   containertyp_id                     NUMBER(38,0)     NOT NULL COMMENT 'ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   spr_id                              NUMBER(38,0)     NOT NULL,
   containertyp_bez                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_CONTAINERTYP_SPR_ZU PRIMARY KEY (mandant_id, containertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung';

