CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label_sensor_state_hist_1 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT.'),
price_label_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PRICE LABEL.'),
price_label_sensor_name STRING(100) NOT NULL OPTIONS(description='A name of the price label sensor.'),
price_label_metric_meas BIGNUMERIC(38,5) OPTIONS(description='A measure of a given price label sensor.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (price_label_sid, price_label_sensor_name) NOT ENFORCED
)
OPTIONS(description='A table containing data of different electronic price label shield sensors states (for example signal strength level or battery charge level).             Source: Solum, Imagotag (ESL)');