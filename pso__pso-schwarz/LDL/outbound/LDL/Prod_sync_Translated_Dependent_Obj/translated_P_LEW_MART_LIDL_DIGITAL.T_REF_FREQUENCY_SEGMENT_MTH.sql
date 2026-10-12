CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_ref_frequency_segment_mth (
mth_fr_segment_sid INTEGER NOT NULL
OPTIONS(description='Ids of frequency segments from rfm model - used (MTH_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
mth_fr_segment_name STRING(100) NOT NULL OPTIONS(description='frequency segments'),
mth_fr_segment_descr STRING(250) OPTIONS(description='Exact description of frequency from rfm model'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (mth_fr_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : frequency segments - referenece');