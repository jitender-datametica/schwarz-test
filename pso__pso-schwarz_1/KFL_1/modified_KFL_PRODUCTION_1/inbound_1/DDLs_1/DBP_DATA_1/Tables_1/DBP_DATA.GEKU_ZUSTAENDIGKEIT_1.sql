--==============================================================
-- Table: geku_zustaendigkeit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_zustaendigkeit_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ZUSTAENDIGKEIT_1 (
   kundenfaktor_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID des Kundenfaktors, aktuell zwischen 1 und 27',
   geku_dwh_artikel_id                 INTEGER     NOT NULL COMMENT 'Eine_1 weitere ID, die Vergleichbarkeit der Artikel_1 über alle Länder ermöglichen soll',
   zustaendigkeit                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Die Zuständigkeit kann beim Markt, beim Fachbereich oder bei beiden liegen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ZUSTAENDIGKEIT PRIMARY KEY (kundenfaktor_id, geku_dwh_artikel_id) NOT ENFORCED
)  COMMENT = 'GEKU - Zuordnungstabelle der geku_dwh_artikel zum Kundenfaktor';
