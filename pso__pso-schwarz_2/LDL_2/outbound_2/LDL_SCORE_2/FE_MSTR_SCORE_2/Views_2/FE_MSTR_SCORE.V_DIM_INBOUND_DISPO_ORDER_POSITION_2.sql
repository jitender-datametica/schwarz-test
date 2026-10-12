/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_inbound_dispo_order_position_2
Description		| The entity contains detailed information about the products for all inbound logistics dispositions.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_inbound_dispo_order_position_2 (inbound_dispo_order_pos_sid
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'), inbound_dispo_order_sid
OPTIONS(description='unique identifier of the corresponding dispositon.'), dispo_nr
OPTIONS(description='A numeric or alphanumeric value which identifies the disposition for the business.'),
transport_unit_seq
OPTIONS(description='the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late'),
order_reference_nr
OPTIONS(description='14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)'),
purchase_order_nr OPTIONS(description='Purchase order number of Wawi'), version_nr
OPTIONS(description='each time a change is done to the order after the order was placed at the supplier_2, the dispo itself receives a new version nr and each order line is marked with this new version number (no matter if this position was actually changed or not)'),
dispo_order_change_reason_cd
OPTIONS(description='indicating what kind of information changed in comparison to the previous version (e.g. the order quantity or the delivery date)'),
delivery_from_dt OPTIONS(description='when does the product need to be delivered at the warehouse earliest'),
delivery_to_dt OPTIONS(description='when does the product need to be delivered at the warehouse latest'),
receiving_party_sid OPTIONS(description='The unique identifier of the receiving party, e.g. regional subsidiary.'),
delivering_party_sid OPTIONS(description='The unique identifier of the delivering party, e.g. the supplier.'),
receiving_site_sid OPTIONS(description='The unique identifier of the receiving site, e.g. central warehouse.'),
delivering_site_sid OPTIONS(description='The unique identifier of the delivery site, e.g. supplier_2 location.'),
double_deck_fg
OPTIONS(description='indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space'),
pallet_type_cd OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'),
pallet_case_factor OPTIONS(description='How many logistic units are packed on the pallet?'), pallet_storage_space_factor
OPTIONS(description='Hoch much pallet storage space is occupied by one unit_2 of the order quantity, e.g. 1 order quantity unit_2 occupies 0.5 pallet storage space'),
case_size_qty OPTIONS(description='How many sales_2 units are packed in the logistic variant?'), pallet_storage_space_meas
OPTIONS(description='Precalculated amount of storage space. (PALLET_CNT * PALLET_STORAGE_SPACE_FACTOR * CASE WHEN DOUBLE_DECK_FG = 1 THEN 0.5 ELSE 1 END)'),
pallet_height_meas
OPTIONS(description='which height does one pallet unit_2 have, i.e. height of all packet product cases plus pallet itself'),
pallet_weight_meas
OPTIONS(description='which weight does one pallet unit_2 have, i.e. weight of all product cases plus pallet itself'))
OPTIONS(DESCRIPTION = `THE ENTITY CONTAINS DETAILED INFORMATION ABOUT THE PRODUCTS FOR ALL INBOUND LOGISTICS DISPOSITIONS.`)
AS SELECT inbound_dispo_order_pos_sid,
 inbound_dispo_order_sid,
 dispo_nr,
 transport_unit_seq,
 order_reference_nr,
 purchase_order_nr,
 version_nr,
 dispo_order_change_reason_cd,
 delivery_from_dt,
 delivery_to_dt,
 receiving_party_sid,
 delivering_party_sid,
 receiving_site_sid,
 delivering_site_sid,
 double_deck_fg,
 pallet_type_cd,
 pallet_case_factor,
 pallet_storage_space_factor,
 case_size_qty,
 pallet_storage_space_meas,
 pallet_height_meas,
 pallet_weight_meas
FROM ldl_score_core.t_dim_inbound_dispo_order_position_2
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;