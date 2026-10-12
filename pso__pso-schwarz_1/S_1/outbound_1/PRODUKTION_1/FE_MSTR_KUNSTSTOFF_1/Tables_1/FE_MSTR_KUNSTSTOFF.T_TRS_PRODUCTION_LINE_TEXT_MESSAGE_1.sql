CREATE TABLE IF NOT EXISTS produktion_fe_mstr_kunststoff.t_trs_production_line_text_message_1 (
production_line_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
text_message STRING(100) NOT NULL OPTIONS(description='Text message to be displayed in production line dashboards'),
text_timestamp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of the text message'),
PRIMARY KEY (production_line_id) NOT ENFORCED
) OPTIONS(description='THE TRANSACTION TABLE FOR PRODUCTION LINE TEXT MESSAGES');