--==============================================================
-- Table: cos_bonuspunkte_blockiert
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_blockiert
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_bonuspunkte_blockiert (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'),
dat_bonuspunkte_blockiert_bis DATE NOT NULL
OPTIONS(description='Datum bis wann die Bonuspunkte blockiert sind. Bonuspunkte werden nicht direkt auf Konto gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.'),
dat_verfall_bonuspunkte_blockiert DATE NOT NULL
OPTIONS(description='Datum, an dem die gesammelten Bonuspunkte verfallen werden.'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='KFL-Land des Kundenkontos, das an Loyalty-Programms teilnimmt.'),
anz_bonuspunkte_blockiert BIGNUMERIC(38,0)
OPTIONS(description='Die gesamte anzahl der blockierten Bonuspunkten auf das Konto.'),
datzeit_update TIMESTAMP
OPTIONS(description='Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_konto_id, dat_bonuspunkte_blockiert_bis) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält, die erworbenen Bonuspunkte bei Kunden, die bis zu einem Datum blockiert sind und später gutgeschrieben werden.,z.B. nach Ablauf der Rückgabefrist.');