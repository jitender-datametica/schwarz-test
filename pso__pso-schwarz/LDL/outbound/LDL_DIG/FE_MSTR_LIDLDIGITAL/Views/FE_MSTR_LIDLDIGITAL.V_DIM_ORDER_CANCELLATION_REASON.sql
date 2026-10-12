CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_order_cancellation_reason (order_cancel_reason_cd,
order_cancel_reason_descr) AS SELECT order_cancel_reason_cd,
 order_cancel_reason_descr
FROM ldl_dig_lec_share.v_dim_order_cancellation_reason
UNION ALL
SELECT '-1',
 '';