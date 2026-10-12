CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_price_hist_2 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_price_scenario_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_item_price BIGNUMERIC(38,5),
curr_cd STRING(3),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_2 angenommen.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_price_scenario_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='values of the price scenario prices used in the non food product development and ordering process             prices which are differenciated by targeted intenal organisation are not included here             CBX: CNT_ITEM_CUST_2, CNT_ITEM_2');