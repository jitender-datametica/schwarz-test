CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.ts_wawi_manual_extraction (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client-ID indicating country.'),
system_key BIGNUMERIC(38,0) NOT NULL OPTIONS(description='System key indicating source system.'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID indicating warehouse.'),
dayend_date DATE NOT NULL OPTIONS(description='Date indicating "dayend".'),
entry_from STRING(255) COLLATE 'und:ci' NOT NULL OPTIONS(description='Text indicating creator of entry.'),
reason STRING(255) COLLATE 'und:ci' NOT NULL OPTIONS(description='Text indicating reason for manual extraction.'),
extracted_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag indicating if extraction has been processed.'),
create_timestamp DATETIME NOT NULL OPTIONS(description='Timestamp when entry was created.'),
extract_timestamp DATETIME OPTIONS(description='Timestamp when extraction was triggered.')
);