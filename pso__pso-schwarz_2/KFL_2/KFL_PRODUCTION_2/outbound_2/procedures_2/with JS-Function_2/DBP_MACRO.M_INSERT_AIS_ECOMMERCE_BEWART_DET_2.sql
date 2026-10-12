CREATE OR REPLACE PROCEDURE `dbp_macro.m_insert_ais_ecommerce_bewart_det`(
  kundenkarte_id STRING,
  mandant_id FLOAT64
)
BEGIN
  -- BigQuery procedures use standard SQL for DML operations
  INSERT INTO `dbp_data.bewart_det_ecommerce_2` (
    kundenkarte_id,
    mandant_id,
    td_update, 
    td_insert  
  )
  VALUES (
    kundenkarte_id,
    cast(mandant_id as int64),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
  );
END;