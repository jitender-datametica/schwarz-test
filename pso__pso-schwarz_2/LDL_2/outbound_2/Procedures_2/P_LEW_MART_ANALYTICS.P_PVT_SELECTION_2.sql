CREATE OR REPLACE PROCEDURE p_lew_mart_analytics.p_pvt_selection(IN I_PROC STRING, IN I_PK_ID FLOAT64, IN I_CLIENT_ID FLOAT64, IN I_USER_ID STRING, IN I_WEEK_ID FLOAT64, IN I_START_DT DATE, IN I_END_DT DATE, IN I_PRICE_RETAIL_NEW FLOAT64, IN I_PRICE_RETAIL_OLD FLOAT64, IN I_COUNTRYWIDE_FG FLOAT64, IN I_SND_PLACEMENT_FG FLOAT64, IN I_FLYER_ID FLOAT64, IN I_RADIO_FG FLOAT64, IN I_TV_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
BEGIN
-- INSERT


IF I_PROC = 'insert' THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM p_lew_mart_analytics.t_pvt_selection_2 WHERE pk_id = @I_PK_ID AND client_id = @I_CLIENT_ID AND user_id = @I_USER_ID AND week_id IS NULL ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_PK_ID AS I_PK_ID,  I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID;

    SET sql_stmt  =  '''INSERT INTO p_lew_mart_analytics.t_pvt_selection_2 (client_id, pk_id, user_id) (SELECT CAST(@I_CLIENT_ID AS INTEGER) AS client_id,   CAST(@I_PK_ID AS INTEGER) AS pk_id,   @I_USER_ID AS user_id) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_PK_ID AS I_PK_ID,  I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID;

    END;
END IF;

-- UPDATE cw


IF I_PROC = 'updateKW' THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM p_lew_mart_analytics.t_pvt_selection_2 WHERE client_id = @I_CLIENT_ID AND user_id = @I_USER_ID AND week_id IS NULL AND pk_id IN (SELECT pk_id    FROM p_lew_mart_analytics.t_pvt_selection_2    WHERE client_id = @I_CLIENT_ID_1     AND user_id = @I_USER_ID_1     AND week_id = @I_WEEK_ID) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID,  I_CLIENT_ID AS I_CLIENT_ID_1,  I_USER_ID AS I_USER_ID_1,  I_WEEK_ID AS I_WEEK_ID;

    SET sql_stmt  =  '''UPDATE p_lew_mart_analytics.t_pvt_selection_2 SET  week_id = CAST(@I_WEEK_ID AS INTEGER) WHERE client_id = @I_CLIENT_ID AND user_id = @I_USER_ID AND week_id IS NULL ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_WEEK_ID AS I_WEEK_ID,  I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID;

    END;
END IF;

-- DELETE item_2


IF I_PROC = 'deleteItem' THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM p_lew_mart_analytics.t_pvt_selection_2 WHERE pk_id = @I_PK_ID AND user_id = @I_USER_ID AND week_id = @I_WEEK_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_PK_ID AS I_PK_ID,  I_USER_ID AS I_USER_ID,  I_WEEK_ID AS I_WEEK_ID;

    END;
END IF;

-- DELETE plan


IF I_PROC = 'deletePlanKW' THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM p_lew_mart_analytics.t_pvt_selection_2 WHERE client_id = @I_CLIENT_ID AND user_id = @I_USER_ID AND week_id = @I_WEEK_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID,  I_WEEK_ID AS I_WEEK_ID;

    END;
END IF;

-- UPDATE plan attributes


IF I_PROC = 'updatePlanAttr' THEN
    BEGIN
    SET sql_stmt  =  '''UPDATE p_lew_mart_analytics.t_pvt_selection_2 SET  start_dt = @I_START_DT,  end_dt = @I_END_DT,  price_retail_new = ROUND(CAST(@I_PRICE_RETAIL_NEW AS NUMERIC), 5),  price_retail_old = ROUND(CAST(@I_PRICE_RETAIL_OLD AS NUMERIC), 5),  countrywide_fg = CAST(@I_COUNTRYWIDE_FG AS INTEGER),  snd_placement_fg = CAST(@I_SND_PLACEMENT_FG AS INTEGER),  flyer_id = CAST(@I_FLYER_ID AS INTEGER),  radio_fg = CAST(@I_RADIO_FG AS INTEGER),  tv_fg = CAST(@I_TV_FG AS INTEGER) WHERE pk_id = @I_PK_ID AND client_id = @I_CLIENT_ID AND user_id = @I_USER_ID AND week_id =   @I_WEEK_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_TIMESTAMP('%FT%H:%M:%S', I_START_DT) AS I_START_DT,  FORMAT_TIMESTAMP('%FT%H:%M:%S', I_END_DT) AS I_END_DT,  I_PRICE_RETAIL_NEW AS I_PRICE_RETAIL_NEW,  I_PRICE_RETAIL_OLD AS I_PRICE_RETAIL_OLD,  I_COUNTRYWIDE_FG AS I_COUNTRYWIDE_FG,  I_SND_PLACEMENT_FG AS I_SND_PLACEMENT_FG,  I_FLYER_ID AS I_FLYER_ID,  I_RADIO_FG AS I_RADIO_FG,  I_TV_FG AS I_TV_FG,  I_PK_ID AS I_PK_ID,  I_CLIENT_ID AS I_CLIENT_ID,  I_USER_ID AS I_USER_ID,  I_WEEK_ID AS I_WEEK_ID;

    END;
END IF;

END;
END;
