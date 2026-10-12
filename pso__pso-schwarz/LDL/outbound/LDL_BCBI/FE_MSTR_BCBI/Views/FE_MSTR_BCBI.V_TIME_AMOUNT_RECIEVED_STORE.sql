CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_time_amount_recieved_store AS SELECT op.client_id,
 op.country_iso,
 op.wh_id,
 op.wh_desc,
 op.loc_sid_wh,
 op.dat_open,
 op.amount_open_stores,
  CASE
  WHEN delivered.amount_delivered_stores IS NULL
  THEN 0
  ELSE CAST(delivered.amount_delivered_stores AS INTEGER)
  END AS amount_delivered_stores
FROM (SELECT client_id,
   country_iso,
   wh_id,
   wh_desc,
   loc_sid_wh,
   dat_open,
   COUNT(loc_sid_wh) AS amount_open_stores
  FROM ldl_bcbi_fe_mstr_bcbi.v_time_detail
  GROUP BY client_id,
   country_iso,
   wh_id,
   loc_sid_wh,
   wh_desc,
   dat_open) AS op
 LEFT JOIN (SELECT client_id,
   country_iso,
   wh_id,
   wh_desc,
   loc_sid_wh,
   dat_open,
   COUNT(loc_sid_wh) AS amount_delivered_stores
  FROM ldl_bcbi_fe_mstr_bcbi.v_time_detail
  WHERE missing_fg = 0
  GROUP BY client_id,
   country_iso,
   wh_id,
   loc_sid_wh,
   wh_desc,
   dat_open) AS delivered ON op.client_id = delivered.client_id AND op.loc_sid_wh = delivered.loc_sid_wh AND op.dat_open
    = delivered.dat_open
ORDER BY 1 NULLS LAST,
 2 NULLS LAST,
 3 NULLS LAST,
 4 NULLS LAST;