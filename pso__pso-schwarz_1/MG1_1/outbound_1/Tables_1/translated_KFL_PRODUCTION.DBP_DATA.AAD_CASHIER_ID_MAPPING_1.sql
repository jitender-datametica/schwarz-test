CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AAD_CASHIER_ID_MAPPING_1 (
HASHED_CASHIER_ID STRING(255) NOT NULL OPTIONS(description='Encrypted (hashed) CashierID'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
KASSIERER_NR STRING(4) NOT NULL OPTIONS(description='Nummer des Kassierers.'),
HASH_GENERATION_DT DATE OPTIONS(description='Last date of the generation of the hashed CashierID'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (HASHED_CASHIER_ID) NOT ENFORCED
) OPTIONS(description=' Contains pseudonymise cashier number');