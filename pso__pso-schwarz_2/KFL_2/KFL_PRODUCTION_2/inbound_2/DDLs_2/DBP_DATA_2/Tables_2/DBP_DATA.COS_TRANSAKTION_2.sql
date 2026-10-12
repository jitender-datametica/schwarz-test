--==============================================================
-- Table: cos_transaktion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_transaktion_2
   generated from Powerdesigner on Mittwoch, 9. August 2023 12:17:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_TRANSAKTION_2 (
   bonuspunkte_transaktion_id          VARCHAR(144)     NOT NULL COMMENT 'Unique key to identify a bonustransaction. Key to get from table bonustransactions to transactions table.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'KFL country_2 of the Loyalty Program.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID of the store.',
   umsatz_brutto                       NUMBER(38,4)     COMMENT 'Total bon value in gross.',
   bon_dat                             DATE             COMMENT 'Creation date of the bon.',
   bon_barcode                         VARCHAR(400)     COMMENT 'Barcode number of the bon.',
   bon_nr                              NUMBER(38,0)     COMMENT 'Full bon number.',
   umsatz_brutto_loyalty               NUMBER(38,4)     COMMENT 'This is the sum on which points are calculated. In the future you can exclude e.g. items from the points calculation, so they make a separate sum for points calculations.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_TRANSAKTION PRIMARY KEY (bonuspunkte_transaktion_id) NOT ENFORCED
)  COMMENT = 'Transactions on which bonus points are calculated. One row per transaction.';
