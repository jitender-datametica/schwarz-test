/* --------------------------------------------------------------------------------
   DDL for table: t_workingtime_plan_store_day_2
   generated from Powerdesigner on Freitag, 5. August 2022 11:13:56
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WORKINGTIME_PLAN_STORE_DAY_2  CLUSTER BY (
      CAL_DT,
      CLIENT_ID 
 )(
   CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   LOC_SID_STORE                       NUMBER(38,0)    NOT NULL COMMENT 'Betrieb/Filiale ; FK auf LOCATION_2;',
   CAL_DT                              DATE            NOT NULL COMMENT 'Tag_2, fuer den geplant wird; PTM:VMIS_PLANTIMEDAY.PLAN_DATE; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.date',
   TURNOVER_NET_VAL                    NUMBER(38,5)    COMMENT 'Geplanter Umsatz(Net); PTM:VMIS_PLANTIMEDAY.TURNOVER; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.turnover',
   SALES_PIECE_QTY                     NUMBER(38,5)    COMMENT 'Geplanter Absatz',
   TURNOVER_PER_HOUR_NET_VAL           NUMBER(38,5)    COMMENT 'Geplanter Umsatz(Net) pro geleisteter/eingesetzter Stunde; PTM:VMIS_PLANTIMEDAY.PERFORMANCE; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.productivity',
   HOURS_TOTAL_CNT                     NUMBER(38,5)    COMMENT 'Gesamte geplante Stunden_2 (Arbeit+Inventur_2+Training+Sonstige); PTM:VMIS_PLANTIMEDAY.PLAN_HOURS; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.totalHours',
   HOURS_WORKING_CNT                   NUMBER(38,5)    COMMENT 'Geplante Stunden_2 fuer Arbeit; PTM:VMIS_PLANTIMEDAY.PLAN_HOURS - (INVENTORY+TRAINING); SAP_GPS:TurnoverPlan.planning.data.weekPlanning.totalHours - (inventoryHours+trainingHours+miscHours)',
   HOURS_INVENTORY_CNT                 NUMBER(38,5)    COMMENT 'Geplante Stunden_2 fuer Inventur_2; PTM:VMIS_PLANTIMEDAY.INVENTORY; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.inventoryHours',
   HOURS_TRAINING_CNT                  NUMBER(38,5)    NOT NULL COMMENT 'Geplante Stunden_2 fuer Einarbeitung/Training; PTM:VMIS_PLANTIMEDAY.TRAINING; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.trainingHours',
   HOURS_MISC_CNT                      NUMBER(38,5)    NOT NULL COMMENT 'Sonstige Stunden_2; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.miscHours',
   PLAN_UPDATE_TMSP                    TIMESTAMP_NTZ(9) COMMENT 'Aenderungszeitstampel;  PTM:VMIS_PLANTIMEDAY.MODDate; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.lastModification',
   SOURCE_SYSTEM                       VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'Quellesystem (PTM/PEP2)',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_WORKINGTIME_PLAN_STORE_DAY PRIMARY KEY (LOC_SID_STORE, CAL_DT, HOURS_TRAINING_CNT, HOURS_MISC_CNT, SOURCE_SYSTEM)
       NOT ENFORCED
)
COMMENT = 'Planungswerte auf Tagesebene in Bezug auf die an diesem Tag_2 insgesamt in der Filiale verfuegbaren Arbeitszeiten. (PTM/SAPGPS)';

