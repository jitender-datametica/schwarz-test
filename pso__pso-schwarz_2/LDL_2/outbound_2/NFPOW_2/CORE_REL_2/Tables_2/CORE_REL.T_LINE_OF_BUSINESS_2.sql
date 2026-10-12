/* --------------------------------------------------------------------------------
   DDL for table: t_line_of_business_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_line_of_business_2 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='Code of the line of business, so far LDL and KFL are used for Lidl and Kaufland.'),
lob_name STRING(100) NOT NULL OPTIONS(description='Name of the line of business.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd) NOT ENFORCED
) OPTIONS(description='Line of business.             distinguishes between Lidl and Kaufland related clients');