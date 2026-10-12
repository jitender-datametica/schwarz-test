CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_inbound_transport_plan_warehouse_position_2 (
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='unique identifier of the order position that is transported'),
logistics_service_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='unique identifier of the site where the logistic service takes place'),
logistics_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistics service, e.g. short-time storage.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dispo_nr STRING(20) NOT NULL OPTIONS(description='business identifier of the dispo'),
transport_plan_pos_seq BIGNUMERIC
OPTIONS(description='indicator for the sequence in which the activities are conducted'),
logistics_company_sid BIGNUMERIC NOT NULL
OPTIONS(description='unique identifier of the hauler that transports the ordered product from one site to another site'),
plan_start_from_dt DATE OPTIONS(description='point in time when the product delivery starts earliest'),
plan_start_to_dt DATE OPTIONS(description='point in time when the products delivery starts latest'),
plan_end_from_dt DATE
OPTIONS(description='point in time when the products need to be at the destination or the service needs to be finished earliest'),
plan_end_to_dt DATE
OPTIONS(description='point in time when the products need to be at the destination or the service needs to be finished latest'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (dwh_valid_from_tmsp, inbound_dispo_order_pos_sid, logistics_service_type_cd, logistics_service_site_sid)
NOT ENFORCED
)
OPTIONS(description='The entity contains information regarding transport for all products of a disposition, i.e. which logistics services are conducted during the transportation of a product (e.g. short-time storage).');