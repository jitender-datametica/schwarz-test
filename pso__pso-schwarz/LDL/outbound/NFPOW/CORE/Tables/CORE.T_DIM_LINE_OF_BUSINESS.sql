/* --------------------------------------------------------------------------------
   DDL for table: t_dim_line_of_business
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_line_of_business (
lob_cd STRING(100) NOT NULL
OPTIONS(description='code of the line of business, so far LDL and KFL are used for Lidl and Kaufland            CORE_REL: t_line_of_business.lob_cd'),
lob_name STRING(100)
OPTIONS(description='name of the line of business            CORE_REL: t_line_of_business.lob_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd) NOT ENFORCED
)
OPTIONS(description='Line of business.             Distinguishes between Lidl and Kaufland related clients.             CORE_REL: T_LINE_OF_BUSINESS');