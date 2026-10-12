/* --------------------------------------------------------------------------------
   DDL for table: t_cal_busyear_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_BUSYEAR_2 (
   busyear                             NUMBER(38,0)     NOT NULL COMMENT 'Geschaftsjahr',
   busyear_begin_month                 NUMBER(38,0)     NOT NULL COMMENT 'Geschaftsjahr beginnt mit Kalendermonat',
   busyear_end_month                   NUMBER(38,0)     NOT NULL COMMENT 'Geschaftsjahr endet mit Kalendermonat',
   busyear_cy_diff                     NUMBER(38,0)     NOT NULL COMMENT 'busyear_calculator; Differenz in Monaten zwischen Geschaftsjahr und Kalenderjahr (z.B. -3 -> by 01.03. ; cy 01.01.)',
   cy_by_seq                           NUMBER(38,0)     NOT NULL COMMENT 'Differenz zu aktuellem Geschaeftsjahr (taeglich aktualisiert)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAL_BUSYEAR PRIMARY KEY (busyear) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. BUSY; Geschaeftsjahr;
             WAWI: x_data.t_cal_busyear_2';

