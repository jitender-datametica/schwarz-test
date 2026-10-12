CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_aad_request_receipt_zu_2 (
bon_id STRING(25) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
aad_request_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Request (Sequence)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id, aad_request_id) NOT ENFORCED
) OPTIONS(description='Contains the receipt associated to a request made in frontend');