CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_planning_inventur_1 AS
SELECT A16.cy_month,
 A16.cy_month_name,
 A140.country_id,
 TRIM(A18.country_iso_cd) AS country_iso_cd,
 A131.wh_id,
 A131.client_id,
 A17.wh_desc,
 A131.store_id,
 A131.orig_store_nr,
 A15.store_desc,
 pa11.anzahlfilialenmitumsatzwawi,
 pa12.anzahlinventuren,
 pa12.inventurdifferenzenlautsic,
 pa12.inventurumsatzlautsic,
   pa12.inventurdifferenzenlautsic / CASE
    WHEN pa12.inventurumsatzlautsic = 0
    THEN NULL
    ELSE pa12.inventurumsatzlautsic
    END * 100 AS inventurverlustinprozent
FROM (SELECT A13.cy_month,
   A12.store_id,
   A12.client_id,
   COUNT(DISTINCT CASE
     WHEN A11.val_retail_asis <> 0
     THEN A11.store_id * 100 + A11.client_id
     ELSE NULL
     END) AS anzahlfilialenmitumsatzwawi
  FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_1 AS A11
   INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_1 AS A12 ON A11.client_id = A12.client_id AND A11.store_id = A12.store_id
     
   INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday_1 AS A13 ON A11.dat_formdate = A13.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi.v_org_store_1 AS A14 ON A12.client_id = A14.client_id AND A12.store_id = A14.store_id
  WHERE (A13.dat_calendar BETWEEN A14.dat_opening AND A14.dat_closing OR A13.dat_calendar >= A14.dat_opening AND A14.dat_closing
      IS NULL)
   AND A11.currency_iso_cd = 'EUR'
  GROUP BY A13.cy_month,
   A12.store_id,
   A12.client_id) AS pa11
 FULL JOIN (SELECT A120.cy_month,
   A130.store_id,
   A130.client_id,
   COUNT(DISTINCT CASE
     WHEN A110.diff_inv <> 0
     THEN A110.inv_id
     ELSE NULL
     END) AS anzahlinventuren,
   SUM(A110.diff_inv) AS inventurdifferenzenlautsic,
   SUM(A110.val_retail_store_inv_stc) AS inventurumsatzlautsic
  FROM ldl_p_lew_mart_msi.v_inv_store_1 AS A110
   INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday_1 AS A120 ON A110.dat_valid_until = A120.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_1 AS A130 ON A110.client_id = A130.client_id AND A110.store_id = A130.store_id
     
  WHERE A110.currency_iso_cd = 'EUR'
  GROUP BY A120.cy_month,
   A130.store_id,
   A130.client_id) AS pa12 ON pa11.client_id = pa12.client_id AND pa11.cy_month = pa12.cy_month AND pa11.store_id = pa12
   .store_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_1 AS A131 ON COALESCE(pa11.client_id, pa12.client_id) = A131.client_id AND
   COALESCE(pa11.store_id, pa12.store_id) = A131.store_id
 INNER JOIN ldl_p_lew_mart_msi.v_ref_client_1 AS A140 ON A131.client_id = A140.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_1 AS A15 ON A131.client_id = A15.client_id AND A131.store_id = A15.store_id
 INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc_1 AS A16 ON COALESCE(pa11.cy_month, pa12.cy_month) = A16.cy_month
 INNER JOIN ldl_p_lew_mart_msi.v_org_wh_1 AS A17 ON A131.client_id = A17.client_id AND A131.wh_id = A17.wh_id
 INNER JOIN ldl_p_lew_mart_msi.v_ref_country_1 AS A18 ON A140.country_id = A18.country_id;