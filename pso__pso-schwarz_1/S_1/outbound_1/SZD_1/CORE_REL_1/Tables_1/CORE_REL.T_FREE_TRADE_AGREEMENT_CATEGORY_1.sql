/* --------------------------------------------------------------------------------
   DDL for table: T_FREE_TRADE_AGREEMENT_CATEGORY_1
   generated from Powerdesigner on Mittwoch, 5. Juli 2023 14:45:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_free_trade_agreement_category_1 (
free_trade_agreement_category_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the category of a free trade agreement.'),
free_trade_agreement_category_name STRING(100) NOT NULL OPTIONS(description='The name of the category.'),
free_trade_agreement_category_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the category.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (free_trade_agreement_category_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the category of the free trade agreement, for example a bilateral agreement. - Source - Manual');