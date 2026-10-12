--==============================================================
-- Table: mgg_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mgg_gruppe_spr_zu_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:32:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MGG_GRUPPE_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   mgg_gruppe_id                       INTEGER     NOT NULL COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   mgg_gruppe_bez                      VARCHAR(100)     COMMENT 'Bezeichnung der MGG Gruppe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MGG_GRUPPE_SPR_ZU PRIMARY KEY (mandant_id, mgg_gruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der MGG Gruppe_1 in unterschiedlichen Sprachen.';
