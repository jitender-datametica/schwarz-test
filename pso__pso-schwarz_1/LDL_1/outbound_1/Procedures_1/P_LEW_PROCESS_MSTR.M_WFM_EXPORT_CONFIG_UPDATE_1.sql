CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.m_wfm_export_config_update`(
  INTERFACE_NAME STRING,
  MIS_SFO_TYPE_ID FLOAT64,
  MOVE_TYPE_DESCR STRING,
  MIS_SFO_TYPE_DESCR STRING,
  MOVE_REASON_DESCR STRING,
  ORDER_TYPE_DESCR STRING,
  WRITEOFF_ZERO_FG FLOAT64,
  ACTIVE_FG FLOAT64,
  ROW_ID FLOAT64
)
BEGIN
  DECLARE msg STRING;
  BEGIN
    -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
    EXECUTE IMMEDIATE """
    /* SQL FOR CURRENT_SALES_PRICES */
    UPDATE `p_lew_process_mstr.t_wfm_export_config_1`
    SET active_fg = @active_fg
    , dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE interface_name = @interface_name
    AND @interface_name = 'current_sales_prices'
    AND row_id = @row_id
    """ USING 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      INTERFACE_NAME AS interface_name, 
      ROW_ID AS row_id;

    -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
    EXECUTE IMMEDIATE """
    /* SQL FOR Store_Delivery */
    UPDATE `p_lew_process_mstr.t_wfm_export_config_1`
    SET active_fg = @active_fg
    , move_type_descr = @move_type_descr
    , order_type_descr = @order_type_descr
    , writeoff_zero_fg = @writeoff_zero_fg
    , dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE interface_name = @interface_name
    AND @interface_name = 'StoreDelivery'
    AND row_id = @row_id
    """ USING 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      MOVE_TYPE_DESCR AS move_type_descr, 
      ORDER_TYPE_DESCR AS order_type_descr, 
      CAST(WRITEOFF_ZERO_FG AS INT64) AS writeoff_zero_fg, 
      INTERFACE_NAME AS interface_name, 
      ROW_ID AS row_id;

    -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
    EXECUTE IMMEDIATE """
    /* SQL FOR sfo_day */
    UPDATE `p_lew_process_mstr.t_wfm_export_config_1`
    SET active_fg = @active_fg
    , move_type_descr = @move_type_descr
    , order_type_descr = @order_type_descr
    , writeoff_zero_fg = @writeoff_zero_fg
    , mis_sfo_type_id = @mis_sfo_type_id
    , mis_sfo_type_descr = @mis_sfo_type_descr
    , move_reason_descr = @move_reason_descr
    , dwh_updated = cast(CURRENT_TIMESTAMP() as DATETIME)
    WHERE interface_name = @interface_name
    AND @interface_name = 'sfo_day'
    AND row_id = @row_id
    """ USING 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      MOVE_TYPE_DESCR AS move_type_descr, 
      ORDER_TYPE_DESCR AS order_type_descr, 
      CAST(WRITEOFF_ZERO_FG AS INT64) AS writeoff_zero_fg, 
      CAST(MIS_SFO_TYPE_ID AS INT64) AS mis_sfo_type_id, 
      MIS_SFO_TYPE_DESCR AS mis_sfo_type_descr, 
      MOVE_REASON_DESCR AS move_reason_descr, 
      INTERFACE_NAME AS interface_name, 
      ROW_ID AS row_id;

    -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
    EXECUTE IMMEDIATE """
    /* SQL FOR writeoff_store */
    UPDATE `p_lew_process_mstr.t_wfm_export_config_1`
    SET active_fg = @active_fg
    , move_reason_descr = @move_reason_descr
    , move_type_descr = @move_type_descr
    , writeoff_zero_fg = @writeoff_zero_fg
    , mis_sfo_type_id = @mis_sfo_type_id
    , mis_sfo_type_descr = @mis_sfo_type_descr
    , dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE interface_name = @interface_name
    AND @interface_name = 'writeoff_store'
    AND row_id = @row_id
    """ USING 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      MOVE_REASON_DESCR AS move_reason_descr, 
      MOVE_TYPE_DESCR AS move_type_descr, 
      CAST(WRITEOFF_ZERO_FG AS INT64) AS writeoff_zero_fg, 
      CAST(MIS_SFO_TYPE_ID AS INT64) AS mis_sfo_type_id, 
      MIS_SFO_TYPE_DESCR AS mis_sfo_type_descr, 
      INTERFACE_NAME AS interface_name, 
      ROW_ID AS row_id;

    -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
    EXECUTE IMMEDIATE """
    /* SQL FOR writeoff_wh */
    UPDATE `p_lew_process_mstr.t_wfm_export_config_1`
    SET active_fg = @active_fg
    , move_reason_descr = @move_reason_descr
    , move_type_descr = @move_type_descr
    , writeoff_zero_fg = @writeoff_zero_fg
    , mis_sfo_type_id = @mis_sfo_type_id
    , mis_sfo_type_descr = @mis_sfo_type_descr
    , dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE interface_name = @interface_name
    AND @interface_name = 'writeoff_wh'
    AND row_id = @row_id
    """ USING 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      MOVE_REASON_DESCR AS move_reason_descr, 
      MOVE_TYPE_DESCR AS move_type_descr, 
      CAST(WRITEOFF_ZERO_FG AS INT64) AS writeoff_zero_fg, 
      CAST(MIS_SFO_TYPE_ID AS INT64) AS mis_sfo_type_id, 
      MIS_SFO_TYPE_DESCR AS mis_sfo_type_descr, 
      INTERFACE_NAME AS interface_name, 
      ROW_ID AS row_id;
      

  EXCEPTION WHEN ERROR THEN
    SET msg = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE = msg;
  END;

END;