--==============================================================
-- Table: ginfo_flaeche_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_flaeche_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_FLAECHE_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   ginfo_flaeche_id                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Fläche. Z.Bsp. ABF-F6.14',
   ginfo_flaeche_typ_id                VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Typ der Flaeche',
   techn_platz_id                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine_2 von Kaufland Facility Management verwaltete Einheit',
   flaeche_quelle_id                   INTEGER     NOT NULL COMMENT 'Flaechendaten kommen aus drei Quellen. 1 = Grundstuecks-, 2 = Immobilien-, 3 = Handelsflaechen',
   ginfo_flaeche_bez                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Fläche. Z.Bsp. Konserven',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_FLAECHE_SPR_ZU PRIMARY KEY (mandant_id, spr_id, ginfo_flaeche_id, ginfo_flaeche_typ_id, techn_platz_id, flaeche_quelle_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Flächen aus dem System GINFO';
