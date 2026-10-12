CREATE OR REPLACE PROCEDURE p_lew_mart_analytics.p_pvt_forecast (
    I_PROC STRING,
    I_START_DT DATE,
    I_END_DT DATE,
    I_PRICE_RETAIL_NEW FLOAT64,
    I_PRICE_RETAIL_OLD FLOAT64,
    I_TV_FG FLOAT64,
    I_FLYER_ID FLOAT64,
    I_SND_PLACEMENT_FG FLOAT64,
    I_COUNTRYWIDE_FG FLOAT64,
    I_RADIO_FG FLOAT64,
    I_PRICE_RETAIL_NEW_EDITED FLOAT64,
    I_PIECE_FORECAST_QTY FLOAT64,
    I_PIECE_FORECAST_QTY_EDITED FLOAT64,
    I_DISCOUNT_REL_PV FLOAT64,
    I_BASELINE_NET_VAL FLOAT64,
    I_PERIOD_FORECAST_DESC STRING,
    I_CLIENT_ID FLOAT64,
    I_USER_ID STRING,
    I_WEEK_ID FLOAT64,
    I_ORIG_ITEM_NR FLOAT64,
    I_PK_ID FLOAT64,
    I_NOTE STRING,
    I_COMMENT_STRNG STRING,
    I_REGION_ID FLOAT64
)
BEGIN
    -- Add predictive data to planned items
    --  MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. 
    IF I_PROC = 'predictionToPlan' THEN
        EXECUTE IMMEDIATE """
            MERGE INTO p_lew_mart_analytics.t_pvt_selection AS selection 
            USING (
                SELECT pk_id
                FROM p_lew_mart_analytics.t_pvt_retro
                WHERE client_id = @I_CLIENT_ID
                  AND orig_item_nr = @I_ORIG_ITEM_NR
            ) AS retro 
            ON selection.client_id = @I_CLIENT_ID
               AND selection.pk_id = retro.pk_id
               AND selection.week_id = @I_WEEK_ID
               AND selection.user_id = @I_USER_ID
            WHEN MATCHED THEN 
                UPDATE SET
                    start_dt = @I_START_DT,
                    end_dt = @I_END_DT,
                    price_retail_new = CAST(@I_PRICE_RETAIL_NEW AS NUMERIC),
                    price_retail_old = CAST(@I_PRICE_RETAIL_OLD AS NUMERIC),
                    tv_fg = CAST(@I_TV_FG AS INT64),
                    flyer_id = CAST(@I_FLYER_ID AS INT64),
                    snd_placement_fg = CAST(@I_SND_PLACEMENT_FG AS INT64),
                    countrywide_fg = CAST(@I_COUNTRYWIDE_FG AS INT64),
                    radio_fg = CAST(@I_RADIO_FG AS INT64),
                    price_retail_new_edited = CAST(@I_PRICE_RETAIL_NEW_EDITED AS NUMERIC),
                    piece_forecast_qty = CAST(@I_PIECE_FORECAST_QTY AS NUMERIC),
                    piece_forecast_qty_edited = CAST(@I_PIECE_FORECAST_QTY_EDITED AS NUMERIC),
                    discount_rel_pv = CAST(@I_DISCOUNT_REL_PV AS NUMERIC),
                    baseline_net_val = CAST(@I_BASELINE_NET_VAL AS NUMERIC),
                    period_forecast_desc = @I_PERIOD_FORECAST_DESC,
                    note = @I_NOTE,
                    comment_strng = @I_COMMENT_STRNG,
                    region_id = CAST(@I_REGION_ID AS INT64)
        """ USING 
            I_CLIENT_ID AS I_CLIENT_ID,
            I_ORIG_ITEM_NR AS I_ORIG_ITEM_NR,
            I_WEEK_ID AS I_WEEK_ID,
            I_USER_ID AS I_USER_ID,
            I_START_DT AS I_START_DT,
            I_END_DT AS I_END_DT,
            I_PRICE_RETAIL_NEW AS I_PRICE_RETAIL_NEW,
            I_PRICE_RETAIL_OLD AS I_PRICE_RETAIL_OLD,
            I_TV_FG AS I_TV_FG,
            I_FLYER_ID AS I_FLYER_ID,
            I_SND_PLACEMENT_FG AS I_SND_PLACEMENT_FG,
            I_COUNTRYWIDE_FG AS I_COUNTRYWIDE_FG,
            I_RADIO_FG AS I_RADIO_FG,
            I_PRICE_RETAIL_NEW_EDITED AS I_PRICE_RETAIL_NEW_EDITED,
            I_PIECE_FORECAST_QTY AS I_PIECE_FORECAST_QTY,
            I_PIECE_FORECAST_QTY_EDITED AS I_PIECE_FORECAST_QTY_EDITED,
            I_DISCOUNT_REL_PV AS I_DISCOUNT_REL_PV,
            I_BASELINE_NET_VAL AS I_BASELINE_NET_VAL,
            I_PERIOD_FORECAST_DESC AS I_PERIOD_FORECAST_DESC,
            I_NOTE AS I_NOTE,
            I_COMMENT_STRNG AS I_COMMENT_STRNG,
            I_REGION_ID AS I_REGION_ID;
    END IF;

    -- Manual edit the forecast data
    -- MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. 
    IF I_PROC = 'edtPredInPlan' THEN
        EXECUTE IMMEDIATE """
            UPDATE p_lew_mart_analytics.t_pvt_selection 
            SET
                start_dt = @I_START_DT,
                end_dt = @I_END_DT,
                price_retail_new = CAST(@I_PRICE_RETAIL_NEW AS NUMERIC),
                price_retail_old =CAST(@I_PRICE_RETAIL_OLD AS NUMERIC),
                tv_fg = CAST(@I_TV_FG AS INT64),
                flyer_id = CAST(@I_FLYER_ID AS INT64),
                snd_placement_fg = CAST(@I_SND_PLACEMENT_FG AS INT64),
                countrywide_fg = CAST(@I_COUNTRYWIDE_FG AS INT64),
                radio_fg = CAST(@I_RADIO_FG AS INT64),
                price_retail_new_edited = CAST(@I_PRICE_RETAIL_NEW_EDITED AS NUMERIC),
                piece_forecast_qty = CAST(@I_PIECE_FORECAST_QTY AS NUMERIC),
                piece_forecast_qty_edited = CAST(@I_PIECE_FORECAST_QTY_EDITED AS NUMERIC),
                discount_rel_pv = CAST(@I_DISCOUNT_REL_PV AS NUMERIC),
                baseline_net_val = CAST(@I_BASELINE_NET_VAL AS NUMERIC),
                period_forecast_desc = @I_PERIOD_FORECAST_DESC,
                note = @I_NOTE,
                comment_strng = @I_COMMENT_STRNG,
                region_id = CAST(@I_REGION_ID AS INT64) 
              WHERE client_id = @I_CLIENT_ID
              AND pk_id = @I_PK_ID
              AND week_id = @I_WEEK_ID
              AND user_id = @I_USER_ID
        """ USING 
            I_START_DT AS I_START_DT,
            I_END_DT AS I_END_DT,
            I_PRICE_RETAIL_NEW AS I_PRICE_RETAIL_NEW,
            I_PRICE_RETAIL_OLD AS I_PRICE_RETAIL_OLD,
            I_TV_FG AS I_TV_FG,
            I_FLYER_ID AS I_FLYER_ID,
            I_SND_PLACEMENT_FG AS I_SND_PLACEMENT_FG,
            I_COUNTRYWIDE_FG AS I_COUNTRYWIDE_FG,
            I_RADIO_FG AS I_RADIO_FG,
            I_PRICE_RETAIL_NEW_EDITED AS I_PRICE_RETAIL_NEW_EDITED,
            I_PIECE_FORECAST_QTY AS I_PIECE_FORECAST_QTY,
            I_PIECE_FORECAST_QTY_EDITED AS I_PIECE_FORECAST_QTY_EDITED,
            I_DISCOUNT_REL_PV AS I_DISCOUNT_REL_PV,
            I_BASELINE_NET_VAL AS I_BASELINE_NET_VAL,
            I_PERIOD_FORECAST_DESC AS I_PERIOD_FORECAST_DESC,
            I_NOTE AS I_NOTE,
            I_COMMENT_STRNG AS I_COMMENT_STRNG,
            I_REGION_ID AS I_REGION_ID,
            I_CLIENT_ID AS I_CLIENT_ID,
            I_PK_ID AS I_PK_ID,
            I_WEEK_ID AS I_WEEK_ID,
            I_USER_ID AS I_USER_ID;
    END IF;
END;