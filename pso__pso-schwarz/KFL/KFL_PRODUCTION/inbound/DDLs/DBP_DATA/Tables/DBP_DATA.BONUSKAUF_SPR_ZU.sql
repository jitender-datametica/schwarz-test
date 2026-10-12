--==============================================================
-- Table: bonuskauf_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BONUSKAUF_SPR_ZU (
   bonuskauf_id                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   bonuskauf_bez                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Bonuskaufs aus bontext, z.Bsp. 3 la pret de 2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BONUSKAUF_SPR_ZU PRIMARY KEY (bonuskauf_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Sprachabhängige Bezeichnungen der Promotions aus zbonus_text';

