--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.rb_faktura_medata_date_2 (
    gjmo INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    rb_status INTEGER DEFAULT 0 NOT NULL
);
