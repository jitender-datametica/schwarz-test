CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_busyear_quarter_1 (busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), busyear OPTIONS(description='Geschaeftsjahr'),
qtr_of_busyear_id OPTIONS(description='quarter of the business year, i.g. 2 if the busyear_qtr is 20212'),
busyear_qtr_name
OPTIONS(description='name of the quarter of the business year, e.g. Q1/2021 if the busyear_qtr is 20211'),
busyear_qtr_begin_month OPTIONS(description='Geschaftsjahresquartal beginnt mit Kalendermonat'), busyear_qtr_end_month
OPTIONS(description='Geschaftsjahresquartal endet mit Kalendermonat'), by_qtr_seq
OPTIONS(description='Differenz zu aktuellem Geschaeftsjahresquartal von gestern ( taeglich aktualisiert)'),
by_qtr_prev_1q
OPTIONS(description='previous quarter of business year\'s , i.g. if the current qurater is 20211 then the previous one is 20204'),
by_qtr_prev_1y OPTIONS(description='quarter of the business year one year ago'), by_qtr_prev_2y
OPTIONS(description='quarter of the business year 2 years ago'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `GESCHÄFTSJAHRESQUARTAL`) AS SELECT busyear_qtr,
 busyear,
 qtr_of_busyear_id,
 busyear_qtr_name,
 busyear_qtr_begin_month,
 busyear_qtr_end_month,
 by_qtr_seq,
 by_qtr_prev_1q,
 by_qtr_prev_1y,
 by_qtr_prev_2y,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_busyear_quarter_1;