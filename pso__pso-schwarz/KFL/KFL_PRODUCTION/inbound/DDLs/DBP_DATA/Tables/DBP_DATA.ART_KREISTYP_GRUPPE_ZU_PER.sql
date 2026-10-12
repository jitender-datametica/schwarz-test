--==============================================================
-- Table: art_kreistyp_gruppe_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kreistyp_gruppe_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_KREISTYP_GRUPPE_ZU_PER (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel - Id',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
   kreistyp_gruppe_id                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Region / Gruppierung Kreistypen',
   kreistyp_id                         VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kreistyp',
   dat_bis                             DATE             NOT NULL COMMENT 'Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_KREISTYP_GRUPPE_ZU_PER PRIMARY KEY (art_id, mandant_id, dat_von, kreistyp_gruppe_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Zeitabhängige Zuordnung der Artikel zu Kreistyp und Kreistypgruppe';

