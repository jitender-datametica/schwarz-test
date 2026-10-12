CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAL_BUSYEAR_QUARTER_1 COMMENT='Geschäftsjahresquartal'
(
BUSYEAR_QTR COMMENT 'Identifier of the quarter of the busines year',
BUSYEAR COMMENT 'Geschaeftsjahr',
QTR_OF_BUSYEAR_ID COMMENT 'quarter of the business year, i.g. 2 if the busyear_qtr is 20212',
BUSYEAR_QTR_NAME COMMENT 'name of the quarter of the business year, e.g. Q1/2021 if the busyear_qtr is 20211',
BUSYEAR_QTR_BEGIN_MONTH COMMENT 'Geschaftsjahresquartal beginnt mit Kalendermonat',
BUSYEAR_QTR_END_MONTH COMMENT 'Geschaftsjahresquartal endet mit Kalendermonat',
BY_QTR_SEQ COMMENT 'Differenz zu aktuellem Geschaeftsjahresquartal von gestern ( taeglich aktualisiert)',
BY_QTR_PREV_1Q COMMENT 'previous quarter of business year''s , i.g. if the current qurater is 20211 then the previous one is 20204',
BY_QTR_PREV_1Y COMMENT 'quarter of the business year one year ago',
BY_QTR_PREV_2Y COMMENT 'quarter of the business year 2 years ago',
DWH_LOAD_ID COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH')

AS SELECT 
BUSYEAR_QTR,
BUSYEAR,
QTR_OF_BUSYEAR_ID,
BUSYEAR_QTR_NAME,
BUSYEAR_QTR_BEGIN_MONTH,
BUSYEAR_QTR_END_MONTH,
BY_QTR_SEQ,
BY_QTR_PREV_1Q,
BY_QTR_PREV_1Y,
BY_QTR_PREV_2Y,
DWH_LOAD_ID,
DWH_CREATED,
DWH_UPDATED
FROM P_LEW_CORE.T_CAL_BUSYEAR_QUARTER_1
;