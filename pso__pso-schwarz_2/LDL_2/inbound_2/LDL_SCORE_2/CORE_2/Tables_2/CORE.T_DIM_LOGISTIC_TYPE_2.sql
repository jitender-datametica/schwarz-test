--==============================================================
-- Table: t_dim_logistic_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistic_type_2
   generated from Powerdesigner on Montag, 5. August 2024 15:42:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOGISTIC_TYPE_2 (
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   logistic_type_descr                 VARCHAR(100)    COMMENT 'A textual description for the logistic_type_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTIC_TYPE PRIMARY KEY (logistic_type_cd) NOT ENFORCED 
)  COMMENT = 'Represents the type of logistic is conducted. 
             The most common types are SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung). 
             In the first case the goods are picked up from a supplier_2 or the supplier_2 delivers directly to a crossdock.
             Next, the goods are delivered to various crossdocks till the last one. From this point the last destination of the products is a Lidl warehouse. 
             The other case would be, that the supplier_2 delivers the products directly to the Lidl warehouse = DL. ';
