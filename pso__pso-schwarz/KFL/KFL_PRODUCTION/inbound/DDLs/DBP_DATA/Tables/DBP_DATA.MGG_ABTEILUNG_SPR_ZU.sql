--==============================================================
-- Table: mgg_abteilung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mgg_abteilung_spr_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:41:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MGG_ABTEILUNG_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   mgg_abteilung_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mgg_abteilung_bez                   VARCHAR(100)     COMMENT 'Bezeichnung der MGG Abteilung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MGG_ABTEILUNG_SPR_ZU PRIMARY KEY (mandant_id, mgg_abteilung_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der MGG Abteilung in unterschiedliche Sprachen.';
