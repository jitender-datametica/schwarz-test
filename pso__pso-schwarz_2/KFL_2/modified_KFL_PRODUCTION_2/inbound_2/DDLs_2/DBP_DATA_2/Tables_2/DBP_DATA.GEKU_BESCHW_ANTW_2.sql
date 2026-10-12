--==============================================================
-- Table: geku_beschw_antw_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_beschw_antw_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_BESCHW_ANTW_2 (
   beschwerde_antwort_id               INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Beschwerdeantwort aus complaint_answer_uid',
   geku_massnahme_uid                  INTEGER     NOT NULL COMMENT 'Eindeutige ID einer GeKu-Massnahme aus measure_uid',
   berechtigt_fg                       INTEGER     COMMENT 'Berechtigt=1 / Unberechtigt=0, aus answer_qualified',
   avg_fg                              INTEGER     COMMENT 'AVG ja = 1, nein = 0
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_BESCHW_ANTW PRIMARY KEY (beschwerde_antwort_id) NOT ENFORCED
)  COMMENT = 'GEKU - Tabelle Beschwerde-Antwort aus s1_dwh_complaint_answer';

