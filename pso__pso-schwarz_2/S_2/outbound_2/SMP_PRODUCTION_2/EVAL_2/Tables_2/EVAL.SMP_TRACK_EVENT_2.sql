DROP TABLE IF EXISTS smp_production_eval.smp_track_event_2;
CREATE OR REPLACE TABLE smp_production_eval.smp_track_event_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
track_event_id STRING(100) NOT NULL,
campaign_id STRING(100) NOT NULL,
campaign_type_id STRING(100),
shopper_id STRING(100) NOT NULL,
impact_score_val FLOAT64 NOT NULL,
smp_bid_val NUMERIC(29,6),
advertiser_bid_val NUMERIC(29,3),
cohort_id STRING(100),
treatment_label_id STRING(100),
universe_id STRING(100),
channel_id STRING(100),
record_dt DATE,
specificity_id STRING(100),
attribution_track_event_start_tmsp DATETIME,
attribution_track_event_end_tmsp DATETIME,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER,
smp_create_tmsp DATETIME
) CLUSTER BY division_id, country_id, record_dt, campaign_id;