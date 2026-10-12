CREATE TABLE CORE_OCTOPUS.T_DIM_LOGISTIC_TYPE (
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   logistic_type_descr                 VARCHAR(100)    COMMENT 'A textual description for the logistic_type_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTIC_TYPE PRIMARY KEY (logistic_type_cd) NOT ENFORCED 
)  COMMENT = 'Represents the type of logistic is conducted. 
             The most common types are SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung). 
             In the first case the goods are picked up from a supplier or the supplier delivers directly to a crossdock.
             Next, the goods are delivered to various crossdocks till the last one. From this point the last destination of the products is a Lidl warehouse. 
             The other case would be, that the supplier delivers the products directly to the Lidl warehouse = DL. ';
