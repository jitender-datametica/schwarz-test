CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_inbound_dispo_order_1 (
inbound_dispo_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dispo_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the disposition for the business.'),
bus_country_cd STRING(2)
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
is_recycled_fg BOOL
OPTIONS(description='The flag sorts out a new DISPOID (ELM), which includes the same information as the old DISPOID. Therefore the old DISPOID is not included in the factual communication.'),
logistic_type_id BIGNUMERIC OPTIONS(description='ID for logistic_temp_cd. e.g. KT has ID 24, TK 25. '),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
direct_dispo_fg BOOL
OPTIONS(description='Flag for a direct dispo. Whether its a direct delivery from the supplier_1 to the Lidl regional distribution center (Direktlauf).'),
combined_logistics_fg BOOL
OPTIONS(description='The flag sorts out combi logistics, which are excluded in the factual communication.'),
logistic_type_cd STRING(20)
OPTIONS(description='The code for the type of the logistic, e.g. Direct- or Collective logistics.'),
dispo_order_status_cd STRING(20)
OPTIONS(description='The code for the status_1 of the disposition (e.g. initialized, approved, sent)'),
dispo_year BIGNUMERIC OPTIONS(description='The dispo year.'),
dispo_week BIGNUMERIC OPTIONS(description='The dispo week.'),
dispo_scheme_descr STRING(100)
OPTIONS(description='LogType + shortcut for cross dock+ cross dock name + target country.'),
order_day_seq BIGNUMERIC OPTIONS(description='An indicator showing which order day within the dispo week.'),
version_nr BIGNUMERIC
OPTIONS(description='A number showing the version of the disposition. It increases with each change.'),
main_crossdock_site_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the cross-dock that is used in case of Collective-Logistics.'),
delivery_from_dt DATE
OPTIONS(description='In case of Collective-Logistics it contains the minimum date of the delivery.'),
delivery_to_dt DATE OPTIONS(description='In case of Collective-Logistics it contains the maximum date of the delivery.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_dispo_order_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The entity contains head information for all inbound logistics dispositions.');