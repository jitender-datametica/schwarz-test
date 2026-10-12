/* --------------------------------------------------------------------------------
   DDL for table: T_EXCHANGE_RATE_TYPE
   generated from Powerdesigner on Donnerstag, 16. November 2023 13:32:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_exchange_rate_type (
exchange_rate_type_cd STRING(50) NOT NULL
OPTIONS(description=' Natural/Business Key - The code identifying the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
exchange_rate_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (exchange_rate_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the ways in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ... - Source - Manual');