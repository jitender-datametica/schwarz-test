--==============================================================
-- Table: ginfo_flaeche_areaattr_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_flaeche_areaattr_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_FLAECHE_AREAATTR_PER_1 (
   techn_platz_id                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine_1 von Kaufland Facility Management verwaltete Einheit',
   flaeche_attribut_id                 INTEGER     NOT NULL COMMENT 'Diese ID wird im DWH generiert und ist ein ganzzahliger Wert',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Endedatum  der Gültigkeit einer Fläche. Bei aktuell gültigen Sätzen ist hier der 31.12.9999 eingetragen',
   flaeche_cad                         NUMBER(29,2)     COMMENT 'Fläche per CAD ermittelt, in der Tabelle ginfo_flaeche_det_per_1 gespeichert',
   flaeche_schaetzung                  NUMBER(29,2)     COMMENT 'Schätzwert der Fläche',
   flaeche_beauftragung                NUMBER(29,2)     COMMENT 'Beauftragte Fläche',
   quelle_beauftragung                 INTEGER     NOT NULL COMMENT 'Angabe, woher die Flächenangabe für die Beauftragung kommt, ob aus cad (1), aus Schätzung (2) oder aus Beauftragung (3)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_FLAECHE_AREAATTR_PER PRIMARY KEY (techn_platz_id, flaeche_attribut_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Beauftragte Flächen mit Quelle der Flächenangaben aus sitecare_area';
