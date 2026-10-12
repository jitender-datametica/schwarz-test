/* --------------------------------------------------------------------------------
   DDL for table: t_time_tracking_record_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_time_tracking_record_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb/Filiale; FK auf LOCATION_1;'),
time_record_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Stempelzeit-Nummer; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.PDSNR'),
time_record_change_dt DATE NOT NULL
OPTIONS(description='Ersatzweise/annaeherungsweise durch Lieferdatum des Belegs gefuellt; ersetzt den eigentlichen Anlage_1/Aenderungszeitstempel des Belegs; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.DAYEND_DATE'),
employee_hash STRING(100) COLLATE 'und:ci'
OPTIONS(description='Verschluesselte Mitarbeiternummer; SAP_GPS: AbscensesWorkingTimes.punches.punch.MIS_KEY'),
time_type_sid BIGNUMERIC(38,0)
OPTIONS(description='An-/Abwesenheitsart, Beschreibungen der Typen liegen in der Ref-Tabelle; SAP_GPS: AbscensesWorkingTimes.punches.punch.ATTABS_TYPE'),
event_type_cd STRING(3) COLLATE 'und:ci'
OPTIONS(description='Beleg-Typ: P10 = kommen, P20 = gehen, P15 = Pausenbeginn, P25 = Pausenende; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.SATZA'),
event_tmsp DATETIME
OPTIONS(description='Eintrittszeitpunkt des Events ("kommen", "Pausenbeginn", "Pausenende", "gehen"); SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE + LTIME'),
event_booking_type_cd STRING(1) COLLATE 'und:ci'
OPTIONS(description='Buchungstyp: wie wurde der Beleg erzeugt; M = Manuel, E = ESS, S = Subsystem, T = Tagesabschluss, A = App); SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.ORIGF '),
cancel_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, ob Satz ein Storno-Beleg ist, d.h. ob er einen anderen Beleg (mit identischer Nummer) storniert; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.STOKZ'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Arbeitstag; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, time_record_id, time_record_change_dt, cancel_fg, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 15289 $ Arbeitszeitevent in der Filialen(repraesentiert "Stempel-Events" zum Erfassen von Arbeitszeiten: ein Eintrag pro "Arbeitsbeginn", "Pausenbeginn", "Pausenende" und "Arbeitsende"); SAP_GPS:AbscensesWorkingTimes.absatt');