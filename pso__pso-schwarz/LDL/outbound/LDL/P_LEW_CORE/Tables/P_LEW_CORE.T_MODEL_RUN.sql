/* --------------------------------------------------------------------------------
   DDL for table: t_model_run
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:20:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_model_run (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key GEO AREA. Unique identifier of the geographical area.'),
run_tmsp DATETIME NOT NULL OPTIONS(description='Relevant timestamp of the model run.'),
active_from_dt DATE NOT NULL
OPTIONS(description='Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
active_to_dt DATE
OPTIONS(description='End of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model.'),
cy_week BIGNUMERIC(38,0)
OPTIONS(description='YYYYKW; WAWI: x_data.t_cal_week.cy_week. Populated in the case that the model is a weekly model.'),
cy_month BIGNUMERIC(38,0)
OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month. Populated in the case that the model is a monthly model.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Sprechender Code, CX, LDL+, AP.'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Eindeutiger code, der mit dem model_area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (model_sid, geo_area_sid, active_from_dt, run_tmsp) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. This table contains the information about runs of models for certain geographical areas and related to a defined time key or range.');