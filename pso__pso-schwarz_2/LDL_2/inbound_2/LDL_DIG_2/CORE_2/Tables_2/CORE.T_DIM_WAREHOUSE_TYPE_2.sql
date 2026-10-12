CREATE TABLE CORE.t_dim_warehouse_type_2 (
   wh_type_cd                          VARCHAR(5)      NOT NULL COMMENT 'The code forthe type for the warehouse (Ausenlager, Versandlager, Zwischenlager)',
   wh_type_descr                       VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type for the warehouse (Ausenlager, Versandlager, Zwischenlager)',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_warehouse_type PRIMARY KEY (wh_type_cd)
   )COMMENT = 'This minor dimension defines the type for the warehouse (Ausenlager, Versandlager, Zwischenlager)';
