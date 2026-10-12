CREATE TABLE P_LEW_CORE.T_CAL_BUSYEAR_QUARTER_2 (
   busyear_qtr                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the quarter of the busines year',
   busyear                             NUMBER(38,0)    COMMENT 'Geschaeftsjahr',
   qtr_of_busyear_id                   NUMBER(38,0)    NOT NULL COMMENT 'quarter of the business year, i.g. 2 if the busyear_qtr is 20212',
   busyear_qtr_name                    VARCHAR(100)    NOT NULL COMMENT 'name of the quarter of the business year, e.g. Q1/2021 if the busyear_qtr is 20211',
   busyear_qtr_begin_month             NUMBER(38,0)    NOT NULL COMMENT 'Geschaftsjahresquartal beginnt mit Kalendermonat',
   busyear_qtr_end_month               NUMBER(38,0)    NOT NULL COMMENT 'Geschaftsjahresquartal endet mit Kalendermonat',
   by_qtr_seq                          NUMBER(38,0)    NOT NULL COMMENT 'Differenz zu aktuellem Geschaeftsjahresquartal von gestern ( taeglich aktualisiert)',
   by_qtr_prev_1q                      NUMBER(38,0)    NOT NULL COMMENT 'previous quarter of business year''s , i.g. if the current qurater is 20211 then the previous one is 20204',
   by_qtr_prev_1y                      NUMBER(38,0)    NOT NULL COMMENT 'quarter of the business year one year ago',
   by_qtr_prev_2y                      NUMBER(38,0)    NOT NULL COMMENT 'quarter of the business year 2 years ago',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_CAL_BUSYEAR_QUARTER PRIMARY KEY (busyear_qtr)
       NOT enforced
)
COMMENT = 'Geschäftsjahresquartal
          ';