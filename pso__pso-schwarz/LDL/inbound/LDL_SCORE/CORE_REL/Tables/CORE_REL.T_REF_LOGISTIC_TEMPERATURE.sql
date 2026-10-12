--==============================================================
-- Table: t_ref_logistic_temperature
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_logistic_temperature
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 09:18:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_LOGISTIC_TEMPERATURE (
   logistic_temp_cd                    VARCHAR(20)      NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   logistic_temp_descr                 VARCHAR(100)     NOT NULL COMMENT 'Logistics temperature can be of types:
            Kühllogistik
            Kühltrockenlogistik
            Trockenlogistik
            Trockenlogistik
            Tiefkühllogistik
            Obst- und Gemüse (O&G) 
            Ultrafrischelogistik',
   logistic_temp_descr_de              VARCHAR(100)     COMMENT 'A textual description for the logistics_temp_cd written out in German.',
   logistic_temp_descr_en              VARCHAR(100)     COMMENT 'A textual description for the logistics_temp_cd written out in English.',
   elm_logistic_temp_id                NUMBER           COMMENT 'ELM: elm_logistictypeid',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_LOGISTIC_TEMPERATURE PRIMARY KEY (logistic_temp_cd) NOT ENFORCED 
)  COMMENT = 'With certain commercial goods (e.g. frozen goods or dry food), it is important not to exceed or fall below a certain temperature range for the product in order not to damage the product. The temperature of the product must therefore be within a certain range when it is delivered. Logistics temperarature defines the types of cooling available in trucks e.g. Kühllogistik';
