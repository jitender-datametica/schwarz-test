CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_competitor_hist_2 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_competitor_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_competitor_seq BIGNUMERIC(38,0) NOT NULL,
nfpo_competitor_sale_price BIGNUMERIC(38,5),
nfpo_competitor_sell_from_dt DATE,
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
PRIMARY KEY (nfpo_item_sid, nfpo_competitor_sid, nfpo_competitor_seq, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='NFPO item_2 level information related to competitors             CBX: CNT_ITEM_2');