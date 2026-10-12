--==============================================================
-- Table: platzierungswg_flaeche_flachetyp_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_flaeche_flachetyp_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 15:09:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PLATZIERUNGSWG_FLAECHE_FLACHETYP_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   platzierungswg_id                   NUMBER(38,0)     NOT NULL COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.',
   ginfo_flaeche_id                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Fläche. Z.Bsp. ABF-F6.14',
   ginfo_flaeche_typ_id                VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Typ der Flaeche.',
   techn_platz_id                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit.',
   flaeche_quelle_id                   NUMBER(38,0)     NOT NULL COMMENT 'Flaechendaten kommen aus drei Quellen. 1 = Grundstuecks-, 2 = Immobilien-, 3 = Handelsflaechen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PLATZIERUNGSWG_FLAECHE_FLACHETYP_ZU PRIMARY KEY (mandant_id, platzierungswg_id, ginfo_flaeche_id, ginfo_flaeche_typ_id, techn_platz_id, flaeche_quelle_id) NOT ENFORCED
)  COMMENT = 'Zuordnung von Platzierungswarengruppen zu ginfo Fläche und ginfo Fläche Typ.';
