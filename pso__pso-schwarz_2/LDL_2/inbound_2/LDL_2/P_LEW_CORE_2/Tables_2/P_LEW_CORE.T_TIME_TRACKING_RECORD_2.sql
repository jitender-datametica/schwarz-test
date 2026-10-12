/* --------------------------------------------------------------------------------
   DDL for table: t_time_tracking_record_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_TIME_TRACKING_RECORD_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb/Filiale; FK auf LOCATION_2;',
   time_record_id                      NUMBER(38,0)     NOT NULL COMMENT 'Stempelzeit-Nummer; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.PDSNR',
   time_record_change_dt               DATE             NOT NULL COMMENT 'Ersatzweise/annaeherungsweise durch Lieferdatum des Belegs gefuellt; ersetzt den eigentlichen Anlage_2/Aenderungszeitstempel des Belegs; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.DAYEND_DATE',
   employee_hash                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Verschluesselte Mitarbeiternummer; SAP_GPS: AbscensesWorkingTimes.punches.punch.MIS_KEY',
   time_type_sid                       NUMBER(38,0)     COMMENT 'An-/Abwesenheitsart, Beschreibungen der Typen liegen in der Ref-Tabelle; SAP_GPS: AbscensesWorkingTimes.punches.punch.ATTABS_TYPE',
   event_type_cd                       VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Beleg-Typ: P10 = kommen, P20 = gehen, P15 = Pausenbeginn, P25 = Pausenende; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.SATZA',
   event_tmsp                          TIMESTAMP_NTZ(9) COMMENT 'Eintrittszeitpunkt des Events ("kommen", "Pausenbeginn", "Pausenende", "gehen"); SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE + LTIME',
   event_booking_type_cd               VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Buchungstyp: wie wurde der Beleg erzeugt; M = Manuel, E = ESS, S = Subsystem, T = Tagesabschluss, A = App); SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.ORIGF ',
   cancel_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Flag, ob Satz ein Storno-Beleg ist, d.h. ob er einen anderen Beleg (mit identischer Nummer) storniert; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.STOKZ',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Arbeitstag; SAP_GPS: AbscensesWorkingTimes.absatt.data.punches.punch.LDATE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_TIME_TRACKING_RECORD PRIMARY KEY (client_id, loc_sid, time_record_id, time_record_change_dt, cancel_fg, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 15289 $ Arbeitszeitevent in der Filialen(repraesentiert "Stempel-Events" zum Erfassen von Arbeitszeiten: ein Eintrag pro "Arbeitsbeginn", "Pausenbeginn", "Pausenende" und "Arbeitsende"); SAP_GPS:AbscensesWorkingTimes.absatt';

