-- Table: t_dim_logistic_temperature_zone_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistic_temperature_zone_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:27:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_logistic_temperature_zone_1 (
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
logistic_temp_descr STRING(100)
OPTIONS(description='A textual description for the logistic_temp_cd written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistic_temp_cd) NOT ENFORCED
)
OPTIONS(description='Describes in what temperature the goods are delivered.  This can be, for example, deep-freeze logistics (Tiefkühllogistik TK) or dry refrigeration logistics (TK Trockenkühllogistik) . and other types.');