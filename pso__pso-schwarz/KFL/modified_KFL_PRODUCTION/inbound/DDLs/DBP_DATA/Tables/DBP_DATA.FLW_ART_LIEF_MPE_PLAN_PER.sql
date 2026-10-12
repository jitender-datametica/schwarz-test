--==============================================================
-- Table: flw_art_lief_mpe_plan_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_lief_mpe_plan_per
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_LIEF_MPE_PLAN_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_lief_id                         INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeit aus gtvon',
   flw_version_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'myMEAT Version zur Marktpreisermittlung aus versi',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeit aus gtbis',
   bruttopreis                         NUMBER(29,4)     NOT NULL COMMENT 'Bruttopreis aus brprs',
   menge                               NUMBER(29,3)     NOT NULL COMMENT 'Menge aus menge',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   nettopreis                          NUMBER(29,4)     NOT NULL COMMENT 'Nettopreis aus ntprs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_LIEF_MPE_PLAN_PER PRIMARY KEY (flw_art_id, flw_lief_id, werk_id, dat_von, flw_version_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - myMEAT MPE: Planpreise aus spmeat_mpe_plan';

