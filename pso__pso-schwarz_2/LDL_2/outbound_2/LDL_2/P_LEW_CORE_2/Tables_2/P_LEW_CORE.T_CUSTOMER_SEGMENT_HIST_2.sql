/* --------------------------------------------------------------------------------
   DDL for table: t_customer_segment_hist_2
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 16:48:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_segment_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Client_id: technically required ba the core loader for historized tables, contains 7 (=Stiftung) for all records'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the customer (surrogate key)'),
segmentation_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENTATION'),
segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENT'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the geographical area (surrogate key)'),
run_tmsp DATETIME NOT NULL OPTIONS(description='relevant timestamp of the model run'),
active_from_dt DATE NOT NULL
OPTIONS(description='begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.'),
active_to_dt DATE
OPTIONS(description='end of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kunde ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (customer_sid, segmentation_sid, geo_area_sid, active_from_dt, dwh_valid_from) NOT ENFORCED
) CLUSTER BY active_from_dt, geo_area_sid, model_group_cd
OPTIONS(description='$Revision: 0000 $. this table contains the assignements of customers to segments');