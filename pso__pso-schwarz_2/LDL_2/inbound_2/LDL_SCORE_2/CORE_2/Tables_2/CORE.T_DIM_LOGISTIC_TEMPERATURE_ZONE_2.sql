-- Table: t_dim_logistic_temperature_zone_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistic_temperature_zone_2
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:27:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOGISTIC_TEMPERATURE_ZONE_2 (
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   logistic_temp_descr                 VARCHAR(100)    COMMENT 'A textual description for the logistic_temp_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTIC_TEMPERATURE_ZONE PRIMARY KEY (logistic_temp_cd) NOT ENFORCED 
)  COMMENT = 'Describes in what temperature the goods are delivered.  This can be, for example, deep-freeze logistics (Tiefkühllogistik TK) or dry refrigeration logistics (TK Trockenkühllogistik) . and other types.';
