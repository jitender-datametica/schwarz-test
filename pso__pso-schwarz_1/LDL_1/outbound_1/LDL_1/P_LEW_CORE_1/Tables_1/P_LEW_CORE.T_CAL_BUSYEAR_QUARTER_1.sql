CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_busyear_quarter_1 (
busyear_qtr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
busyear BIGNUMERIC(38,0) OPTIONS(description='Geschaeftsjahr'),
qtr_of_busyear_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='quarter of the business year, i.g. 2 if the busyear_qtr is 20212'),
busyear_qtr_name STRING(100) NOT NULL
OPTIONS(description='name of the quarter of the business year, e.g. Q1/2021 if the busyear_qtr is 20211'),
busyear_qtr_begin_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschaftsjahresquartal beginnt mit Kalendermonat'),
busyear_qtr_end_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaftsjahresquartal endet mit Kalendermonat'),
by_qtr_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Differenz zu aktuellem Geschaeftsjahresquartal von gestern ( taeglich aktualisiert)'),
by_qtr_prev_1q BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='previous quarter of business year\'s , i.g. if the current qurater is 20211 then the previous one is 20204'),
by_qtr_prev_1y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='quarter of the business year one year ago'),
by_qtr_prev_2y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='quarter of the business year 2 years ago'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (busyear_qtr) NOT ENFORCED
) OPTIONS(description='Geschäftsjahresquartal          ');