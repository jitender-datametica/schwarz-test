CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_transport_plan_position_1 (
inbound_transport_plan_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='Unique identifier (surrogate key) of the transport plan position'),
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
transport_plan_pos_seq BIGNUMERIC
OPTIONS(description='indicator for the sequence in which the activities are conducted'),
transport_start_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
transport_end_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
plan_start_from_dt DATE OPTIONS(description='Point in time when the product delivery starts earliest'),
plan_end_to_dt DATE
OPTIONS(description='Point in time when the products need to be at the destination or the service needs to be finished latest'),
plan_end_from_dt DATE
OPTIONS(description='Point in time when the products need to be at the destination or the service needs to be finished earliest'),
plan_start_to_dt DATE OPTIONS(description='Point in time when the products delivery starts latest'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_transport_plan_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.');