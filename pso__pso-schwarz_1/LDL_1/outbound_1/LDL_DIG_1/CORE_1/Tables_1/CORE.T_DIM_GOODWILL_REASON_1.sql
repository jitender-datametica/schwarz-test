/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_GOODWILL_REASON_1
   GENERATED FROM POWERDESIGNER ON Freitag, 15. Dezember 2023 15:13:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_goodwill_reason_1 (
goodwill_reason_cd STRING(5) NOT NULL OPTIONS(description='The code for the goodwill reason.'),
goodwill_reason_descr_en STRING(250) NOT NULL
OPTIONS(description='The textual description of the goodwill reason in English.'),
goodwill_reason_descr_de STRING(250) NOT NULL
OPTIONS(description='The textual description of the goodwill reason in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (goodwill_reason_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension describes the available goodwill reasons');