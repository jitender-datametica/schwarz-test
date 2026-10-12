--==============================================================
-- Table: T_DIM_INTERVAL_MINUTE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERVAL_MINUTE_1
   generated from Powerdesigner on Montag, 26. Juni 2023 19:26:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_interval_minute_1 (
interval_min_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The 1 Minute interval of day, i.e.a number in the range from 0 to 1499 as a number representing 1 minute intervals with uniqueness based on end time & summertime flag. Intervalls are approximated to full minute like\'00:01:00\' as end time.'),
interval_min_begin_tm TIME NOT NULL
OPTIONS(description='The start time (inclusive) of the 1-minute interval. E.g. 00:00:01 for the interval from 00:00:01 to 00:01:00.'),
interval_min_end_tm TIME NOT NULL
OPTIONS(description='The end time (inclusive) of the 1-minute interval. E.g. 00:01:00 for the interval from 00:00:01 to 00:01:00'),
summertime_fg BOOL NOT NULL OPTIONS(description='Flag for summertime overlap of 1 hour between summer- & wintertime'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (interval_min_hr) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - This minor dimension contains the 1 minute intervalls day including sommertime flag for 1 hour overlap - Source - manually filled.');