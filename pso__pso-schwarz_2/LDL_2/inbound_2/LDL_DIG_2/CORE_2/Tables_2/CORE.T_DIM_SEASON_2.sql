CREATE TABLE CORE.T_DIM_SEASON_2 (
   SEASON_NR                           VARCHAR(20)     NOT NULL COMMENT 'Unique season ID (Primary Key) in the source system',
   SEASON_START_MON_DT_NR              NUMBER          COMMENT 'Date when season starts in format of month concatenated with date',
   SEASON_END_MON_DT_NR                NUMBER          COMMENT 'Date when season ends in format of month concatenated with date',
   SEASON_NAME                         VARCHAR(100)    COMMENT 'Name of the seasons in group language ( German )',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SEASON PRIMARY KEY (SEASON_NR)
       NOT ENFORCED
)COMMENT = 'A dimension that defines season relevant for LD selling goods ( f.e. winter, Halloween , New Year , etc), country_2 independent';
