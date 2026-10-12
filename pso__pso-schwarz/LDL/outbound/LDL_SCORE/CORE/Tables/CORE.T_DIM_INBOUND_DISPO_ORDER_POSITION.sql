--==============================================================
-- Table: t_dim_inbound_dispo_order_position
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_inbound_dispo_order_position
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:14:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_inbound_dispo_order_position (
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
inbound_dispo_order_sid BIGNUMERIC OPTIONS(description='unique identifier of the corresponding dispositon.'),
dispo_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the disposition for the business.'),
transport_unit_seq BIGNUMERIC
OPTIONS(description='the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late'),
order_reference_nr STRING(250)
OPTIONS(description='14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)'),
purchase_order_nr STRING(20) OPTIONS(description='Purchase order number of Wawi'),
version_nr BIGNUMERIC
OPTIONS(description='each time a change is done to the order after the order was placed at the supplier, the dispo itself receives a new version nr and each order line is marked with this new version number (no matter if this position was actually changed or not)'),
dispo_order_change_reason_cd STRING(20)
OPTIONS(description='indicating what kind of information changed in comparison to the previous version (e.g. the order quantity or the delivery date)'),
delivery_from_dt DATE OPTIONS(description='when does the product need to be delivered at the warehouse earliest'),
delivery_to_dt DATE OPTIONS(description='when does the product need to be delivered at the warehouse latest'),
receiving_party_sid BIGNUMERIC
OPTIONS(description='The unique identifier of the receiving party, e.g. regional subsidiary.'),
delivering_party_sid BIGNUMERIC OPTIONS(description='The unique identifier of the delivering party, e.g. the supplier.'),
receiving_site_sid BIGNUMERIC
OPTIONS(description='The unique identifier of the receiving site, e.g. central warehouse.'),
delivering_site_sid BIGNUMERIC
OPTIONS(description='The unique identifier of the delivery site, e.g. supplier location.'),
double_deck_fg BOOL
OPTIONS(description='indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space'),
pallet_type_cd STRING(20)
OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'),
pallet_cnt BIGNUMERIC NOT NULL OPTIONS(description='The total number of pallets that have been ordered.'),
adv_pallet_cnt BIGNUMERIC
OPTIONS(description='The total number of pallets that have been ordered as part of an advertising campaign.'),
missing_pallet_cnt BIGNUMERIC OPTIONS(description='The total number of pallets that are missing'),
pallet_case_factor BIGNUMERIC(38,5) OPTIONS(description='How many logistic units are packed on the pallet?'),
pallet_storage_space_factor BIGNUMERIC(38,5)
OPTIONS(description='Hoch much pallet storage space is occupied by one unit of the order quantity, e.g. 1 order quantity unit occupies 0.5 pallet storage space'),
case_size_qty BIGNUMERIC(38,5) OPTIONS(description='How many sales units are packed in the logistic variant?'),
pallet_storage_space_meas BIGNUMERIC(38,5)
OPTIONS(description='Precalculated amount of storage space. (PALLET_CNT * PALLET_STORAGE_SPACE_FACTOR * CASE WHEN DOUBLE_DECK_FG = 1 THEN 0.5 ELSE 1 END)'),
pallet_height_meas BIGNUMERIC(38,5)
OPTIONS(description='which height does one pallet unit have, i.e. height of all packet product cases plus pallet itself'),
pallet_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='which weight does one pallet unit have, i.e. weight of all product cases plus pallet itself'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_dispo_order_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The entity contains detailed information about the products for all inbound logistics dispositions.');