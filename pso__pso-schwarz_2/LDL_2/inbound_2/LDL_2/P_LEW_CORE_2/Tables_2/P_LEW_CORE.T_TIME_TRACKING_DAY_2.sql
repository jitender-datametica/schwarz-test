/* --------------------------------------------------------------------------------
   DDL for table: t_time_tracking_day_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:22
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_TIME_TRACKING_DAY_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb/Filiale; FK auf LOCATION_2',
   time_record_id                      NUMBER(38,0)     NOT NULL COMMENT 'Beleg-Nummer SAP_GPS: AbscensesWorkingTimes.absences.absence.DOCNR',
   time_record_change_dt               DATE             NOT NULL COMMENT 'letzte Aenderung des Belegs (ersatzweise/annaeherungsweise durch Lieferdatum des Belegs gefuellt); ersetzt den eigentlichen Anlage_2/Aenderungszeitstempel des Belegs; SAP_GPS: AbscensesWorkingTimes.absences.absence.DAYEND_DATE',
   employee_hash                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Verschluesselte Mitarbeiternummer; SAP_GPS: AbscensesWorkingTimes.absences.absence.MIS_KEY',
   time_type_sid                       NUMBER(38,0)     COMMENT 'An-/Abwesenheitsart, Beschreibungen der Typen liegen in der Ref-Tabelle; SAP_GPS: AbscensesWorkingTimes.absences.absence.ATTABS_TYPE',
   hours_cnt                           NUMBER(9,5)      COMMENT 'An-/Abwesenheit in Stunden_2; SAP_GPS: AbscensesWorkingTimes.absences.absence.HOURS',
   cancel_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Flag, ob Satz ein Storno-Beleg ist, d.h. ob er einen anderen Beleg (mit identischer Nummer) storniert; SAP_GPS: AbscensesWorkingTimes.absences.absence.STATUS_2',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Arbeitstag; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_TIME_TRACKING_DAY PRIMARY KEY (client_id, loc_sid, time_record_id, time_record_change_dt, cancel_fg, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 11352 $: Taegliche An-/Abwesenheit; SAP_GPS: AbscensesWorkingTimes.absences';

