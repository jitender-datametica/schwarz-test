create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_MSI.V_INV_WH_EJR_TXJ_WW_1(
	CLIENT_ID,
	WH_ID,
	INV_ID,
	INV_START_DATE,
	INV_END_DATE,
	CURRENCY_ISO_CD,
	VAL_RETAIL,
	VAL_RETAIL_NET
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_MSI
 as
SELECT
    sales.client_id,
    wh.src_wh_id AS wh_id,
    COALESCE(wawi_inv.inv_id, CAST(1 AS INTEGER)) AS inv_id,
    COALESCE(wawi_inv.inv_start_date, sales.dat_formdate) AS inv_start_date,
    COALESCE(
        wawi_inv.inv_end_date,
        sales.dat_formdate
    ) AS inv_end_date,
    erkh.curr_cd_from AS currency_iso_cd,
    sales.val_retail / erkh.exchange_rate AS val_retail,
    sales.val_retail_net / erkh.exchange_rate AS val_retail_net
FROM
    p_lew_bil_ac.v_agg_sales_store_day_1 AS sales_1 -- Auflösung von Store zu WH
    INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS s2wh ON s2wh.client_id = sales.client_id
    AND s2wh.loc_sid_store = sales.loc_sid_store
    INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh ON wh.client_id = s2wh.client_id
    AND wh.loc_sid_wh = s2wh.loc_sid_wh
    AND wh.dwh_actual_fg = 1
    AND wh.active_fg = 1
    AND wh.bges_active_fg = 1 -- Währungskurse bestimmen
    INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS erkh ON erkh.client_id = sales.client_id
    AND CURRENT_DATE BETWEEN erkh.active_from_dt
    AND erkh.active_to_dt
    AND CURRENT_DATE BETWEEN erkh.dwh_valid_from
    AND erkh.dwh_valid_to
    INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert ON ert.client_id = erkh.client_id
    AND ert.x_rate_type_sid = erkh.x_rate_type_sid
    AND ert.src_kurst = '@BEWE' -- Nur für die WaWI-Umsätze wird ein Inventurzeitbereich bestimmt, unter welchem die Umsätze für WaWI-WHs summiert angezeigt werden
    LEFT OUTER JOIN (
        SELECT
            tgt.client_id,
            tgt.wh_loc_sid,
            tgt.inv_id,
            tgt.inv_start_date,
            tgt.inv_end_date
        FROM
(
                SELECT
                    grp.client_id,
                    grp.wh_loc_sid,
                    grp.inv_id,
                    MAX(grp.dat_formdate) OVER (
                        PARTITION BY grp.client_id,
                        grp.wh_loc_sid
                        ORDER BY
                            grp.dat_formdate ASC ROWS BETWEEN 1 Preceding
                            AND 1 Preceding
                    ) + 1 AS inv_start_date,
                    grp.dat_formdate AS inv_end_date
                FROM
                    (
                        SELECT
                            client_id,
                            wh_loc_sid,
                            inv_id,
                            dat_formdate
                        FROM
                            p_lew_core_ac.v_wawi_inv_item_wh_1
                        WHERE
                            inv_type = 'F'
                        GROUP BY
                            client_id,
                            wh_loc_sid,
                            inv_id,
                            dat_formdate
                    ) AS grp
            ) AS tgt
        WHERE
            (
                tgt.client_id,
                tgt.wh_loc_sid,
                tgt.inv_start_date,
                tgt.inv_end_date
            ) NOT IN (
                SELECT
                    grp.client_id,
                    grp.wh_loc_sid,
                    grp.inv_start_date,
                    grp.inv_end_date
                FROM
                    (
                        SELECT
                            client_id,
                            wh_loc_sid,
                            MAX(dat_formdate) OVER (
                                PARTITION BY client_id,
                                wh_loc_sid
                                ORDER BY
                                    dat_formdate ASC ROWS BETWEEN 1 Preceding
                                    AND 1 Preceding
                            ) + 1 AS inv_start_date,
                            dat_formdate AS inv_end_date
                        FROM
                            p_lew_core_ac.v_wawi_inv_item_wh_1
                        WHERE
                            client_id = 1
                            AND inv_type = 'F'
                    ) AS grp
                WHERE
                    EXTRACT(
                        YEAR
                        FROM
                            inv_start_date
                    ) = 2015
                    AND EXTRACT(
                        YEAR
                        FROM
                            inv_end_date
                    ) = 2020
                GROUP BY
                    1,
                    2,
                    3,
                    4
            )
    ) AS wawi_inv ON wawi_inv.client_id = sales.client_id
    AND wawi_inv.wh_loc_sid = wh.loc_sid_wh
    AND sales.dat_formdate BETWEEN wawi_inv.inv_start_date
    AND wawi_inv.inv_end_date
WHERE
    (
        (
            wh.src_werks IS NULL
            AND wawi_inv.client_id IS NOT NULL
        )
        /* Wenn es kein migriertes WH ist, muss eine_1 Inventur_1 vorliegen*/
        OR wh.src_werks IS NOT NULL
    );
