/* --------------------------------------------------------------------------------
   DDL for table: t_workingtime_plan_store_day_1
   generated from Powerdesigner on Freitag, 5. August 2022 11:13:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_workingtime_plan_store_day_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb/Filiale ; FK auf LOCATION_1;'),
cal_dt DATE NOT NULL
OPTIONS(description='Tag_1, fuer den geplant wird; PTM:VMIS_PLANTIMEDAY.PLAN_DATE; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.date'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Geplanter Umsatz(Net); PTM:VMIS_PLANTIMEDAY.TURNOVER; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.turnover'),
sales_piece_qty BIGNUMERIC(38,5) OPTIONS(description='Geplanter Absatz'),
turnover_per_hour_net_val BIGNUMERIC(38,5)
OPTIONS(description='Geplanter Umsatz(Net) pro geleisteter/eingesetzter Stunde; PTM:VMIS_PLANTIMEDAY.PERFORMANCE; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.productivity'),
hours_total_cnt BIGNUMERIC(38,5)
OPTIONS(description='Gesamte geplante Stunden_1 (Arbeit+Inventur_1+Training+Sonstige); PTM:VMIS_PLANTIMEDAY.PLAN_HOURS; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.totalHours'),
hours_working_cnt BIGNUMERIC(38,5)
OPTIONS(description='Geplante Stunden_1 fuer Arbeit; PTM:VMIS_PLANTIMEDAY.PLAN_HOURS - (INVENTORY+TRAINING); SAP_GPS:TurnoverPlan.planning.data.weekPlanning.totalHours - (inventoryHours+trainingHours+miscHours)'),
hours_inventory_cnt BIGNUMERIC(38,5)
OPTIONS(description='Geplante Stunden_1 fuer Inventur_1; PTM:VMIS_PLANTIMEDAY.INVENTORY; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.inventoryHours'),
hours_training_cnt BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Geplante Stunden_1 fuer Einarbeitung/Training; PTM:VMIS_PLANTIMEDAY.TRAINING; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.trainingHours'),
hours_misc_cnt BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Sonstige Stunden_1; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.miscHours'),
plan_update_tmsp DATETIME
OPTIONS(description='Aenderungszeitstampel;  PTM:VMIS_PLANTIMEDAY.MODDate; SAP_GPS:TurnoverPlan.planning.data.weekPlanning.lastModification'),
source_system STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Quellesystem (PTM/PEP2)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (loc_sid_store, cal_dt, hours_training_cnt, hours_misc_cnt) NOT ENFORCED
) CLUSTER BY cal_dt, client_id
OPTIONS(description='Planungswerte auf Tagesebene in Bezug auf die an diesem Tag_1 insgesamt in der Filiale verfuegbaren Arbeitszeiten. (PTM/SAPGPS)');