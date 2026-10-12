CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_early_delivery_hist_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_early_deliv_seq BIGNUMERIC(38,0) NOT NULL,
nfpo_item_early_deliv_cal_week BIGNUMERIC(38,0),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_1 angenommen.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_item_early_deliv_seq, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='list of possible early delivery weeks for items, initially planned independently from the relation of items to advertise themes             CBX: CNT_ITEM_1');