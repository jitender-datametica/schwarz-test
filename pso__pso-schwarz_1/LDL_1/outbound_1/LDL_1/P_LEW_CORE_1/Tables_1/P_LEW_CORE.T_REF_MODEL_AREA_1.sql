CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_model_area_1 (
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_area_descr STRING(250) OPTIONS(description='description of the model area'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (model_area_cd) NOT ENFORCED
)
OPTIONS(description='top level of model classification for analytical models, for example LDL+ or CX, one model area includes all model groups relatad to certain specific data like Lidl+ customer data, customer experience data, assortment scoring /  prediction data          ');