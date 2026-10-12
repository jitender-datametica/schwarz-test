CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label_price_hist_2 (
electronic_price_label_type_cd STRING(100) NOT NULL OPTIONS(description='The code indicating the price label type.'),
price_label_producer_name STRING(100) NOT NULL
OPTIONS(description='The name of the company that manufactures price labels.'),
curr_iso_cd STRING(3) NOT NULL
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
net_price BIGNUMERIC(38,5) OPTIONS(description='Netto price in given currency.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (electronic_price_label_type_cd, price_label_producer_name, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Contains prices of the price shields themselves. Currently contains only prices of electronic price label shields in USD.             Source: Manual (ESL)');