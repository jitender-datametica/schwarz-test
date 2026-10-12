CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_POS_PAYMENT_TYPE
(
  payment_type_id
, payment_type_descr
, mapping_attr_id
, mapping_attr_descr
)
AS
SELECT
payment_type_id,
payment_type_descr,
mapping_attr_id,
mapping_attr_descr
FROM p_lew_mart_lead.v_ref_pos_payment_type;


