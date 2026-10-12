/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_inbound_dispo_order_position
Description		| The entity contains detailed information about the products for all inbound logistics dispositions.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INBOUND_DISPO_ORDER_POSITION(
	INBOUND_DISPO_ORDER_POS_SID COMMENT 'The unique identifier (surrogate key) for the disposition position.',
	INBOUND_DISPO_ORDER_SID COMMENT 'unique identifier of the corresponding dispositon.',
	DISPO_NR COMMENT 'A numeric or alphanumeric value which identifies the disposition for the business.',
	TRANSPORT_UNIT_SEQ COMMENT 'the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late',
	ORDER_REFERENCE_NR COMMENT '14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)',
	PURCHASE_ORDER_NR COMMENT 'Purchase order number of Wawi',
	VERSION_NR COMMENT 'each time a change is done to the order after the order was placed at the supplier, the dispo itself receives a new version nr and each order line is marked with this new version number (no matter if this position was actually changed or not)',
	DISPO_ORDER_CHANGE_REASON_CD COMMENT 'indicating what kind of information changed in comparison to the previous version (e.g. the order quantity or the delivery date)',
	DELIVERY_FROM_DT COMMENT 'when does the product need to be delivered at the warehouse earliest',
	DELIVERY_TO_DT COMMENT 'when does the product need to be delivered at the warehouse latest',
	RECEIVING_PARTY_SID COMMENT 'The unique identifier of the receiving party, e.g. regional subsidiary.',
	DELIVERING_PARTY_SID COMMENT 'The unique identifier of the delivering party, e.g. the supplier.',
	RECEIVING_SITE_SID COMMENT 'The unique identifier of the receiving site, e.g. central warehouse.',
	DELIVERING_SITE_SID COMMENT 'The unique identifier of the delivery site, e.g. supplier location.',
	DOUBLE_DECK_FG COMMENT 'indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space',
	PALLET_TYPE_CD COMMENT 'A code for the pallet that indicates the storage occupation for transportation.',
	PALLET_CASE_FACTOR COMMENT 'How many logistic units are packed on the pallet?',
	PALLET_STORAGE_SPACE_FACTOR COMMENT 'Hoch much pallet storage space is occupied by one unit of the order quantity, e.g. 1 order quantity unit occupies 0.5 pallet storage space',
	CASE_SIZE_QTY COMMENT 'How many sales units are packed in the logistic variant?',
  PALLET_STORAGE_SPACE_MEAS COMMENT 'Precalculated amount of storage space. (PALLET_CNT * PALLET_STORAGE_SPACE_FACTOR * CASE WHEN DOUBLE_DECK_FG = 1 THEN 0.5 ELSE 1 END)',
	PALLET_HEIGHT_MEAS COMMENT 'which height does one pallet unit have, i.e. height of all packet product cases plus pallet itself',
	PALLET_WEIGHT_MEAS COMMENT 'which weight does one pallet unit have, i.e. weight of all product cases plus pallet itself'
) COMMENT='The entity contains detailed information about the products for all inbound logistics dispositions.'
 AS 
SELECT
   inbound_dispo_order_pos_sid
  ,inbound_dispo_order_sid
  ,dispo_nr
  ,transport_unit_seq
  ,order_reference_nr
  ,purchase_order_nr
  ,version_nr
  ,dispo_order_change_reason_cd
  ,delivery_from_dt
  ,delivery_to_dt
  ,receiving_party_sid
  ,delivering_party_sid
  ,receiving_site_sid
  ,delivering_site_sid
  ,double_deck_fg
  ,pallet_type_cd
  ,pallet_case_factor
  ,pallet_storage_space_factor
  ,case_size_qty
  ,pallet_storage_space_meas
  ,pallet_height_meas
  ,pallet_weight_meas
FROM CORE.T_DIM_INBOUND_DISPO_ORDER_POSITION
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
;