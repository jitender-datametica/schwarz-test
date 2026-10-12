CREATE TABLE CORE_OCTOPUS.T_DIM_FLAG_2 (
   fg                                  BOOLEAN         NOT NULL COMMENT 'The flag (true or false)',
   fg_name                             VARCHAR(100)    NOT NULL COMMENT 'The name for the flag (yes / no) in group language, i.e. German.',
   fg_name_de                          VARCHAR(100)    COMMENT 'The name for the flag (yes / no) in.German.',
   fg_name_en                          VARCHAR(100)    COMMENT 'The name for the flag (yes / no) in English.',
   fg_short_name                       VARCHAR(100)    NOT NULL COMMENT 'The abbreviation for the flag (Y/N) in group language, i.e. German.',
   fg_short_name_de                    VARCHAR(100)    COMMENT 'The abbreviation for the flag (Y/N) in.German.',
   fg_short_name_en                    VARCHAR(100)    COMMENT 'The abbreviation for the flag (Y/N) in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_FLAG PRIMARY KEY (fg) NOT ENFORCED 
)  COMMENT = 'If the frontend requires a list of values for flags (i.e. true and false), this minor dimension can be used as a lookup.';
