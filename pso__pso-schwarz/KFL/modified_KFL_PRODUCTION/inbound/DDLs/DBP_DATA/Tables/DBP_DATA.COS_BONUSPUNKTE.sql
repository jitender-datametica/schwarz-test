--==============================================================
-- Table: cos_bonuspunkte
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:29:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSPUNKTE (
   crm_konto_id                        VARCHAR(144)     NOT NULL COMMENT 'Identifier of the LoyaltyAccounts table.',
   dat_verfall_bonuspunkte             DATE             NOT NULL COMMENT 'Date when the anz_bonuspunkte expires and gets deleted.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'KFL country of the Loyalty Program.',
   anz_bonuspunkte                     INTEGER     COMMENT 'Shows the actual total value of points on a loyalty account, what a customer got from one transaction.',
   datzeit_update                      TIMESTAMP_LTZ(9) COMMENT 'Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSPUNKTE PRIMARY KEY (crm_konto_id, dat_verfall_bonuspunkte) NOT ENFORCED
)  COMMENT = 'Bonus points accumulated by Customer. A customer may have several bonuspoints accumulation(rows in table) with different expiry date (dat_verfall_bonuspunkte) ';
