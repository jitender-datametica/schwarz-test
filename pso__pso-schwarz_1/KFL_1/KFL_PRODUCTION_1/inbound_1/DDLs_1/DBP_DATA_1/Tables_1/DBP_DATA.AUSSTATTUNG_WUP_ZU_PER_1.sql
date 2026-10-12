--==============================================================
-- Table: ausstattung_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausstattung_wup_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSSTATTUNG_WUP_ZU_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer aus t001w.werks',
   ausstattung_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID des Ausstattungsmerkmals. Wird im DWH vergeben',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Satz Gültigkeit hat',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT
            ',
   anzahl                              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl, z.Bsp. Anzahl Kundenkassen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSSTATTUNG_WUP_ZU_PER PRIMARY KEY (mandant_id, wup_id, ausstattung_id, dat_von) NOT ENFORCED
)  COMMENT = 'VIS - Welche Ausstattung besitzt ein Markt in welcher Anzahl';

