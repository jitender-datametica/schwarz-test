CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_logistic_type (
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
OPTIONS(description='Represents the type of logistic is conducted.              The most common types are SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung).              In the first case the goods are picked up from a supplier or the supplier delivers directly to a crossdock.             Next, the goods are delivered to various crossdocks till the last one. From this point the last destination of the products is a Lidl warehouse.              The other case would be, that the supplier delivers the products directly to the Lidl warehouse = DL. ');