CREATE OR REPLACE PROCEDURE `dbp_macro.m_delete_ais_ecommerce_bewart_det`(
  kundenkarte_id STRING,
  mandant_id FLOAT64,
  loesch_fg FLOAT64
)
BEGIN
  /*
    The logic only executes the DELETE if loesch_fg is equal to 1.
    BigQuery handles this efficiently within a standard DELETE statement.
  */
  DECLARE smt STRING;
  SET  smt = '''DELETE FROM `dbp_data.bewart_det_ecommerce`
  WHERE kundenkarte_id = ?
    AND mandant_id = ?
    AND ? = 1''';
    execute immediate(smt) using  kundenkarte_id,  mandant_id,  loesch_fg;

  -- Optional: return a status message to match Snowflake's behavior
  SELECT 'Operation completed' AS status;
END;