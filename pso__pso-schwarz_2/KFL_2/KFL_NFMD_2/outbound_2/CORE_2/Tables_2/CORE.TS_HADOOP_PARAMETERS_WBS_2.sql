/* FOR PARAMETER WRITEBACK FROM MSI TO MODEL */


-- kann nach der Migration weg
 -- brauchen wir dies wirklich ??
 CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_hadoop_parameters_wbs_2
(
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant_2 ID'),
land_id STRING(255) OPTIONS(description='Land_2 ID'),
discount_steps BIGNUMERIC(38,0) OPTIONS(description='Abstand zwischen zwei Rabatten - Pflege uebers Frontend'),
price_ending STRING(255) OPTIONS(description='User Parameter for Price Threshold'),
discount_count BIGNUMERIC(38,0) OPTIONS(description='Max. Anzahl der Rabattierung - Pflege uebers Frontend'),
min_discount BIGNUMERIC(38,0) OPTIONS(description='Mindest Rabatt - Pflege uebers Frontend'),
max_discount BIGNUMERIC(38,0) OPTIONS(description='Maximaler Rabatt - Pflege uebers Frontend'),
min_price FLOAT64 OPTIONS(description='min. Warenwert - Pflege uebers Frontend'),
no_touch_time BIGNUMERIC(38,0) OPTIONS(description='No Touch Zeitraum- Pflege uebers Frontend'),
time_btw_discounts BIGNUMERIC(38,0) OPTIONS(description='Anzahl Tage zwischen zwei Rabatten - Pflege uebers Frontend'),
discount_days STRING(255) OPTIONS(description='Wochentag des Rabatts - Pflege uebers Frontend'),
created_at DATETIME OPTIONS(description='Zeitpunkt der Erstellung der Parameter'),
user_id STRING(100) OPTIONS(description='Ersteller'),
valid_to_number_of_days BIGNUMERIC(38,0) OPTIONS(description='Preisgueltigkeit - Pflege uebers Frontend'),
price_ending_threshold BIGNUMERIC(38,0) OPTIONS(description='Preisendung - Pflege uebers Frontend'),
max_discount_for_max_price BIGNUMERIC(38,0) OPTIONS(description='Max Rabatt ab Wert x - Pflege uebers Frontend'),
max_price_for_max_discount BIGNUMERIC(38,0)
OPTIONS(description='Wert x fuer anderen max Rabatt - Pflege uebers Frontend'),
discount_ending BIGNUMERIC(38,0)
OPTIONS(description='Rundung auf Rabatt: 0 - Rabatt 1 - Preis - Pflege uebers Frontend'),
dates_btw_discounts BIGNUMERIC(38,0) OPTIONS(description='Zweiter Rabatt muss innerhalb dieser Tage gegeben werden')
);