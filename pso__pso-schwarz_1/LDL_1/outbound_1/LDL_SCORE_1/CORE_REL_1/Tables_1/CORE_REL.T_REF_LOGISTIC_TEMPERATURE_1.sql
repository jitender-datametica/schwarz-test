--==============================================================
-- Table: t_ref_logistic_temperature_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_logistic_temperature_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 09:18:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_logistic_temperature_1 (
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
logistic_temp_descr STRING(100) NOT NULL
OPTIONS(description='Logistics temperature can be of types:            Kühllogistik            Kühltrockenlogistik            Trockenlogistik            Trockenlogistik            Tiefkühllogistik            Obst- und Gemüse (O&G)             Ultrafrischelogistik'),
logistic_temp_descr_de STRING(100)
OPTIONS(description='A textual description for the logistics_temp_cd written out in German.'),
logistic_temp_descr_en STRING(100)
OPTIONS(description='A textual description for the logistics_temp_cd written out in English.'),
elm_logistic_temp_id BIGNUMERIC OPTIONS(description='ELM: elm_logistictypeid'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistic_temp_cd) NOT ENFORCED
)
OPTIONS(description='With certain commercial goods (e.g. frozen goods or dry food), it is important not to exceed or fall below a certain temperature range for the product in order not to damage the product. The temperature of the product must therefore be within a certain range when it is delivered. Logistics temperarature defines the types of cooling available in trucks e.g. Kühllogistik');