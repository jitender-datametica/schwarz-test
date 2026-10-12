--==============================================================
-- Table: l_bq_findung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bq_findung_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:09:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_BQ_FINDUNG_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   bq_findung_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_BQ_FINDUNG PRIMARY KEY (mandant_id, bq_findung_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle der Ausstiegspunkte bei der Bezugsquellenfindung - initial versorgt';
