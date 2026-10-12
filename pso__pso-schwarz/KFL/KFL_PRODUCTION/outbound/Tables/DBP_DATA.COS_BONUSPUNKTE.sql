--==============================================================
-- Table: cos_bonuspunkte
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:29:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_bonuspunkte (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='Identifier of the LoyaltyAccounts table.'),
dat_verfall_bonuspunkte DATE NOT NULL OPTIONS(description='Date when the anz_bonuspunkte expires and gets deleted.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='KFL country of the Loyalty Program.'),
anz_bonuspunkte BIGNUMERIC(38,0)
OPTIONS(description='Shows the actual total value of points on a loyalty account, what a customer got from one transaction.'),
datzeit_update TIMESTAMP
OPTIONS(description='Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_konto_id, dat_verfall_bonuspunkte) NOT ENFORCED
)
OPTIONS(description='Bonus points accumulated by Customer. A customer may have several bonuspoints accumulation(rows in table) with different expiry date (dat_verfall_bonuspunkte) ');