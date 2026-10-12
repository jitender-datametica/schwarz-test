CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_ref_recency_segment_group_mth_1 (
mth_re_segment_group_sid INTEGER NOT NULL OPTIONS(description='ids of recency segments group'),
mth_re_segment_group_name STRING(100) NOT NULL OPTIONS(description='recency segments group'),
mth_re_segment_group_active_fg INTEGER NOT NULL
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'),
mth_re_segment_group_active_fg_name STRING(20) NOT NULL OPTIONS(description='Description for Segment Activation'),
mth_re_segment_sid INTEGER NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (mth_re_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : recency segments group - reference');