--==============================================================
-- Table: in_kostenstelle_spr_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_kostenstelle_spr_zu_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_KOSTENSTELLE_SPR_ZU_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn des Gültigkeitszeitraums aus datab',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums aus datbi, bei offenen Datensätzen ist dies 31.12.9999',
   kostenstelle_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Kostenstelle aus ltext',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_KOSTENSTELLE_SPR_ZU_PER PRIMARY KEY (mandant_id, kostenstelle_id, krk_id, dat_von, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen dern Kostenstellen aus Industrie aus cskt';
