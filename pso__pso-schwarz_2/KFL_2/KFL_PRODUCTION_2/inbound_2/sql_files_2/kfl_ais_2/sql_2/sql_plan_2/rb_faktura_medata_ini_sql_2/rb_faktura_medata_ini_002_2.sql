--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.rb_faktura_medata_date_2  (
gjmo INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
rb_status BYTEINT NOT NULL DEFAULT 0
)
;

