CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_segment_hist_2 (client_id
OPTIONS(description='Client_id: technically required ba the core loader for historized tables, contains 7 (=Stiftung) for all records'),
customer_sid OPTIONS(description='unique identifier of the customer (surrogate key)'), segmentation_sid
OPTIONS(description='Surrogate Key SEGMENTATION'), segment_sid OPTIONS(description='Surrogate Key SEGMENT'), model_sid
OPTIONS(description='Surrogate Key MODEL'), geo_area_sid
OPTIONS(description='unique identifier of the geographical area (surrogate key)'), run_tmsp
OPTIONS(description='relevant timestamp of the model run'), active_from_dt
OPTIONS(description='begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.'),
active_to_dt
OPTIONS(description='end of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.'),
model_area_cd OPTIONS(description='sprechender Code, CX, LDL+,AP'), model_group_cd
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'), deleted_fg
OPTIONS(description='Kunde ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. THIS TABLE CONTAINS THE ASSIGNEMENTS OF CUSTOMERS TO SEGMENTS`) AS SELECT
 client_id,
 customer_sid,
 segmentation_sid,
 segment_sid,
 model_sid,
 geo_area_sid,
 run_tmsp,
 active_from_dt,
 active_to_dt,
 model_area_cd,
 model_group_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_segment_hist_2;