/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for Std
#----------------------------------------------------------------------------
# History:
# 1.0 05.08.2021 Panaeru, Raman              Creation
#----------------------------------------------------------------------------
*/
Create or REPLACE VIEW p_lew_load.v_location_item_price_1
AS
SELECT
  y.client_id
, y.loc_sid
, y.item_sid
, y.dwh_cal_dt
, y.price_retail
, y.price_level

FROM
(
    SELECT
      ipg.client_id
    , ipg.st_loc_sid
    , ipg.wh_loc_sid
    , ipg.pricegroup_id
    , ipg.priority
    , ipg.dat_valid_from
    , ipg.dat_valid_until
    FROM p_lew_core_ac.v_wawi_itm_pricegroup_1 AS ipg
    -- Take only relevant records to prevent unnecessary multiplications in join
    WHERE ipg.client_id     IN (SELECT client_id       FROM p_lew_load.t_location_item_price_tmp_1)
    AND ipg.dat_valid_from  <= (SELECT Max(dwh_cal_dt) FROM p_lew_load.t_location_item_price_tmp_1)
    AND ipg.dat_valid_until >= (SELECT Min(dwh_cal_dt) FROM p_lew_load.t_location_item_price_tmp_1)
) AS drv1

INNER JOIN
(
    SELECT
      x.client_id
    , x.loc_sid_search
    , x.loc_sid
    , x.item_sid
    , x.dwh_cal_dt
    , x.price_level
    , x.wh_loc_sid
    , drv2.price_retail
    , drv2.pricegroup_id
    , drv2.dat_valid_from
    FROM
    (
        SELECT
          ipr.client_id
        , ipr.item_sid
        , ipr.pricegroup_id
        , ipr.price_retail
        , ipr.dat_valid_from
        , ipr.dat_valid_until
        FROM p_lew_core_ac.v_wawi_itm_price_1 AS ipr
        -- Take only relevant records to prevent unnecessary multiplications in join
        WHERE ipr.client_id     IN (SELECT client_id       FROM p_lew_load.t_location_item_price_tmp_1)
        AND ipr.dat_valid_from  <= (SELECT Max(dwh_cal_dt) FROM p_lew_load.t_location_item_price_tmp_1)
        AND ipr.dat_valid_until >= (SELECT Min(dwh_cal_dt) FROM p_lew_load.t_location_item_price_tmp_1)
    ) AS drv2

    INNER JOIN
    (

        -- Store Level
        SELECT
          t.client_id
        , t.loc_sid
        , t.item_sid
        , t.dwh_cal_dt
        , t.loc_sid AS loc_sid_search
        , Cast(1 AS BYTEINT) AS price_level
        , Cast(NULL AS INTEGER) wh_loc_sid
        FROM p_lew_load.t_location_item_price_tmp_1 AS t
        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS lmk
        ON  t.client_id = lmk.client_id
        AND t.loc_sid   = lmk.loc_sid
        AND lmk.loc_cd  = 'A'
        
        UNION ALL
        
        -- Warehouse Level
        SELECT
          t.client_id
        , t.loc_sid
        , t.item_sid
        , t.dwh_cal_dt
        , lmk2.loc_sid AS loc_sid_search
        , Cast(1 AS BYTEINT) AS price_level
        , Cast(NULL AS INTEGER) wh_loc_sid
        FROM p_lew_load.t_location_item_price_tmp_1 AS t

        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS lmk
        ON  t.client_id = lmk.client_id
        AND t.loc_sid   = lmk.loc_sid
        AND lmk.loc_cd  = 'B'

        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS lmk2
        ON  lmk.client_id      = lmk2.client_id
        AND lmk.wawi_dwh_wh_id = lmk2.wawi_dwh_orig_store_nr
        AND lmk2.loc_cd        = 'A'
        
        UNION ALL
        
        -- Warehouse-for-store Level
        SELECT
          t.client_id
        , t.loc_sid
        , t.item_sid
        , t.dwh_cal_dt
        , mps.loc_sid AS loc_sid_search
        , Cast(2 AS BYTEINT) AS price_level
        , Cast(NULL AS INTEGER) wh_loc_sid
        FROM p_lew_load.t_location_item_price_tmp_1 AS t
        INNER JOIN p_lew_core_ac.v_store_to_wh_delivery_hist_1 AS stw
        ON  t.client_id        = stw.client_id
        AND t.loc_sid          = stw.loc_sid_store
        AND t.dwh_cal_dt       BETWEEN stw.active_from_dt AND stw.active_to_dt
        AND t.dwh_cal_dt       BETWEEN stw.dwh_valid_from AND stw.dwh_valid_to
        AND stw.item_grp_sid   = (-1) * stw.client_id
        AND stw.deleted_fg     = 0
        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS mpw
        ON  stw.client_id      = mpw.client_id
        AND stw.loc_sid_wh     = mpw.loc_sid
        AND mpw.loc_cd         = 'B'
        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS mps
        ON  mpw.client_id      = mps.client_id
        AND mpw.wawi_dwh_wh_id = mps.wawi_dwh_orig_store_nr
        AND mps.loc_cd         = 'A'
        
        UNION ALL
        
        -- Country_1 Level
        SELECT
          t.client_id
        , t.loc_sid
        , t.item_sid
        , t.dwh_cal_dt
        , lmk.loc_sid AS loc_sid_search
        , Cast(3 AS BYTEINT) AS price_level
        , Coalesce(stw.loc_sid_wh, t.loc_sid) AS wh_loc_sid
        FROM p_lew_load.t_location_item_price_tmp_1 AS t
        INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS lmk
        ON  t.client_id = lmk.client_id
        AND lmk.wawi_dwh_store_id = 0
        LEFT OUTER JOIN p_lew_core_ac.v_store_to_wh_delivery_hist_1 AS stw
        ON  t.client_id        = stw.client_id
        AND t.loc_sid          = stw.loc_sid_store
        AND t.dwh_cal_dt       BETWEEN stw.active_from_dt AND stw.active_to_dt
        AND t.dwh_cal_dt       BETWEEN stw.dwh_valid_from AND stw.dwh_valid_to
        AND stw.item_grp_sid   = (-1) * stw.client_id
        AND stw.deleted_fg     = 0
        
    ) AS x
    ON  drv2.client_id  = x.client_id
    AND drv2.item_sid   = x.item_sid
    AND x.dwh_cal_dt BETWEEN drv2.dat_valid_from AND drv2.dat_valid_until
    
    QUALIFY Row_Number() Over (PARTITION BY x.client_id, x.loc_sid, x.loc_sid_search, x.item_sid, x.dwh_cal_dt, drv2.pricegroup_id
                               ORDER BY drv2.dat_valid_from DESC)
            = 1
) AS y

ON  drv1.client_id      = y.client_id
AND drv1.st_loc_sid     = y.loc_sid_search
AND drv1.pricegroup_id  = y.pricegroup_id
AND y.dwh_cal_dt BETWEEN drv1.dat_valid_from AND drv1.dat_valid_until

WHERE (y.price_level <> 3 OR drv1.wh_loc_sid = y.wh_loc_sid)

QUALIFY Row_Number() Over (PARTITION BY y.client_id, y.loc_sid, y.item_sid, y.dwh_cal_dt
                           ORDER BY drv1.priority DESC, y.dat_valid_from DESC, drv1.pricegroup_id)
        = 1;