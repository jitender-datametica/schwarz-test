/* --------------------------------------------------------------------------------
   DDL for table: t_customer_score_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:10:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_score_1 (
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the customer (surrogate key)'),
score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SCORE TYPE'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the geographical area (surrogate key)'),
run_tmsp DATETIME NOT NULL OPTIONS(description='relevant timestamp of the model run'),
active_from_dt DATE NOT NULL
OPTIONS(description='begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
score_measure NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (score_type_sid, model_sid, geo_area_sid, active_from_dt, run_tmsp, customer_sid) NOT ENFORCED
) CLUSTER BY active_from_dt, geo_area_sid, model_group_cd
OPTIONS(description='$Revision: 0000 $. this table contains the calculated scores for customers which have been calculated in model runs of models for customer segmentation');