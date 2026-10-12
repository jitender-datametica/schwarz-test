--==============================================================
-- Table: ginfo_betr_t_platz_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_betr_t_platz_zu_per
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_BETR_T_PLATZ_ZU_PER (
   ginfo_id                            INTEGER     NOT NULL COMMENT 'Vom Ginfo-System verwaltete eindeutige ID des technischen Platzes. Die techn_platz_id ist nicht immer eindeutig. Vorläufig wird die ginfo_id nur in dieser Tabelle verwendet',
   betreiberart_id                     INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Betreiberart. Wird im DWH generiert',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   techn_platz_id                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_BETR_T_PLATZ_ZU_PER PRIMARY KEY (ginfo_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Zuordnungstabelle der Betreiberarten zu technischen Plätzen';
