--==============================================================
-- Table: ginfo_flaeche_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_flaeche_typ_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_FLAECHE_TYP_SPR_ZU_1 (
   ginfo_flaeche_typ_id                VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Typ der Flaeche',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   flaeche_quelle_id                   INTEGER     NOT NULL COMMENT 'Flaechendaten kommen aus drei Quellen. 1 = Grundstuecks-, 2 = Immobilien-, 3 = Handelsflaechen',
   ginfo_flaeche_typ_bez               VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Flächentyps',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_FLAECHE_TYP_SPR_ZU PRIMARY KEY (ginfo_flaeche_typ_id, mandant_id, spr_id, flaeche_quelle_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Flächentypen';
