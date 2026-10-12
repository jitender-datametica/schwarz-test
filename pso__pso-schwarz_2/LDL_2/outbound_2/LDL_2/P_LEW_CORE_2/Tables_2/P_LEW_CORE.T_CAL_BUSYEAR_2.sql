/* --------------------------------------------------------------------------------
   DDL for table: t_cal_busyear_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_busyear_2 (
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaftsjahr'),
busyear_begin_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaftsjahr beginnt mit Kalendermonat'),
busyear_end_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaftsjahr endet mit Kalendermonat'),
busyear_cy_diff BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='busyear_calculator; Differenz in Monaten zwischen Geschaftsjahr und Kalenderjahr (z.B. -3 -> by 01.03. ; cy 01.01.)'),
cy_by_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Differenz zu aktuellem Geschaeftsjahr (taeglich aktualisiert)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (busyear) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. BUSY; Geschaeftsjahr;             WAWI: x_data.t_cal_busyear_2');