CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_ref_monetary_segment_wk (
wk_mo_segment_sid INTEGER NOT NULL OPTIONS(description='ids of NEW monetary segments from rfm model'),
wk_mo_segment_name STRING(100) NOT NULL OPTIONS(description='NEW monetary segments, m_segment: high, medium, low'),
wk_mo_segment_descr STRING(250) OPTIONS(description='exact description of NEW monetary segments from rfm model'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (wk_mo_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : NEW monetary segments - referenece table');