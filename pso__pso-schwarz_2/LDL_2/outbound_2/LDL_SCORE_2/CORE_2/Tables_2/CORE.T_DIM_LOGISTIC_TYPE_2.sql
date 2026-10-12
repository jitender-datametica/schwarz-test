--==============================================================
-- Table: t_dim_logistic_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistic_type_2
   generated from Powerdesigner on Montag, 5. August 2024 15:42:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_logistic_type_2 (
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
logistic_type_descr STRING(100)
OPTIONS(description='A textual description for the logistic_type_cd written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistic_type_cd) NOT ENFORCED
)
OPTIONS(description='Represents the type of logistic is conducted.              The most common types are SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung).              In the first case the goods are picked up from a supplier_2 or the supplier_2 delivers directly to a crossdock.             Next, the goods are delivered to various crossdocks till the last one. From this point the last destination of the products is a Lidl warehouse.              The other case would be, that the supplier_2 delivers the products directly to the Lidl warehouse = DL. ');