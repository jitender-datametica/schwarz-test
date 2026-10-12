/* --------------------------------------------------------------------------------
   DDL for table: t_time_tracking_day
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_time_tracking_day (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb/Filiale; FK auf LOCATION'),
time_record_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Beleg-Nummer SAP_GPS: AbscensesWorkingTimes.absences.absence.DOCNR'),
time_record_change_dt DATE NOT NULL
OPTIONS(description='letzte Aenderung des Belegs (ersatzweise/annaeherungsweise durch Lieferdatum des Belegs gefuellt); ersetzt den eigentlichen Anlage/Aenderungszeitstempel des Belegs; SAP_GPS: AbscensesWorkingTimes.absences.absence.DAYEND_DATE'),
employee_hash STRING(100) COLLATE 'und:ci'
OPTIONS(description='Verschluesselte Mitarbeiternummer; SAP_GPS: AbscensesWorkingTimes.absences.absence.MIS_KEY'),
time_type_sid BIGNUMERIC(38,0)
OPTIONS(description='An-/Abwesenheitsart, Beschreibungen der Typen liegen in der Ref-Tabelle; SAP_GPS: AbscensesWorkingTimes.absences.absence.ATTABS_TYPE'),
hours_cnt NUMERIC(9,5)
OPTIONS(description='An-/Abwesenheit in Stunden; SAP_GPS: AbscensesWorkingTimes.absences.absence.HOURS'),
cancel_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, ob Satz ein Storno-Beleg ist, d.h. ob er einen anderen Beleg (mit identischer Nummer) storniert; SAP_GPS: AbscensesWorkingTimes.absences.absence.STATUS'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Arbeitstag; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, time_record_id, time_record_change_dt, cancel_fg, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 11352 $: Taegliche An-/Abwesenheit; SAP_GPS: AbscensesWorkingTimes.absences');