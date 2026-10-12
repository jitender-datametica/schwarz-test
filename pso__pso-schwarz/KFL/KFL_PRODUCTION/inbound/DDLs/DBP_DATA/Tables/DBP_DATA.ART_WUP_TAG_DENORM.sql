--==============================================================
-- Table: art_wup_tag_denorm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_tag_denorm
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_TAG_DENORM (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Hier sind nur Artikel hinterlegt, die bestimmten Kriterien genügen (dispomerkmal,kdis,listung_id)',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   aktion_fg                           NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag vom Wert 1 oder 0. Wenn = 1, ist der Artikel in Aktion',
   dat_naechst_verkaufstag             DATE             NOT NULL COMMENT 'Datum des nächsten Verkaufstages. Wird ermittelt aus planlieferzeit, Öffnungskalender und Früh/Spätmarktkennzeichen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_TAG_DENORM PRIMARY KEY (art_id, mandant_id, wup_id, dat) NOT ENFORCED
)  COMMENT = 'FLW - in dieser Tabelle sind denormalisiert Merkmale abgelegt. Die Tabelle wird zunächst nur für FLW- und Prognose-relevante Artikel befüllt';

