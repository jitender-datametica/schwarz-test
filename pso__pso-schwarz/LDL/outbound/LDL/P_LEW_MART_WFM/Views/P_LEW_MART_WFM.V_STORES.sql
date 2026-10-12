CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_stores (country_lidl_cd, wh_id, closed_fg, orig_store_nr, mde_lang_cd,
sales_manager_id, qty_min_dflt, store_desc, region_cd, dat_opening, dat_closing, dat_valid_from, dat_opening_ovis,
dat_closing_ovis, dat_real_opening, ord_unit_valid_store_cd, longitude, latitude, zip_code, city, street, house_number)
AS /* for the region_cd, test_store_fg */ /* stores */
/* Only select opend stores resp. stores which open in the next 14 days */ /* Exclude test stores */
/* Exclude closed stores */
/* Exclude stores which represent a warehouse 
AND (loc.client_id, loc.src_orig_store_nr) NOT IN (SELECT
client_id, src_wh_id
FROM LDL.p_lew_core_ac.v_location
   WHERE CURRENT_DATE > opening_dt
   AND wh_store_mark = 'B') */
SELECT CNTRY.src_country_lidl_cd AS country_lidl_cd,
 ST2WH.orig_wh_nr AS wh_id,
 W.closed_fg,
 COALESCE(ST2WH.orig_store_nr, LOC.src_orig_store_nr) AS orig_store_nr,
 W.mde_lang_cd,
 COALESCE(ORG.sales_manager_id, - 100) AS sales_manager_id,
 W.qty_min_dflt,
 LOC.loc_name AS store_desc,
 NULL AS region_cd,
 LOC.opening_dt AS dat_opening,
 LOC.closing_dt AS dat_closing,
 W.dat_valid_from,
 W.dat_opening_ovis,
 W.dat_closing_ovis,
 LOC.real_opening_dt AS dat_real_opening,
 W.ord_unit_valid_store_cd,
 LOC.longitude,
 LOC.latitude,
 ADR.zip_code,
 ADR.city,
 ADR.street,
 ADR.house_number1 AS house_number
FROM ldl_p_lew_core_ac.v_location AS LOC
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LOC_HIST ON LOC.loc_sid = LOC_HIST.loc_sid AND LOC_HIST.deleted_fg = 0
  AND CURRENT_DATE BETWEEN LOC_HIST.dwh_valid_from AND LOC_HIST.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON LOC.client_id = CNTRY.country_sid
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS ST2WH ON LOC.client_id = ST2WH.client_id AND LOC.loc_sid = ST2WH.loc_sid_store
     AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to /* for sales_manager_id */
 LEFT JOIN ldl_p_lew_core_ac.v_location_organization_hist AS ORG ON LOC.client_id = ORG.client_id AND LOC.loc_sid = ORG
     .loc_sid AND ORG.deleted_fg = 0 AND CURRENT_DATE BETWEEN ORG.dwh_valid_from AND ORG.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store AS W ON LOC.client_id = W.client_id AND LOC.loc_sid = W.st_loc_sid AND
   CURRENT_DATE BETWEEN W.dat_rec_start AND W.dat_rec_end /* for address details */
 LEFT JOIN ldl_p_lew_core.t_address AS ADR ON LOC_HIST.addr_sid = ADR.addr_sid
WHERE LOC.wh_store_mark = 'A'
 AND DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY) > LOC.opening_dt
  -- AND loc_hist.test_store_fg <> 1                  /* Exclude test stores

 AND (LOC_HIST.test_store_fg IS NULL OR LOC_HIST.test_store_fg = 0)
 AND (LOC.closing_dt IS NULL OR DATE(LOC.closing_dt) > CURRENT_DATE)
 AND ST2WH.orig_store_nr <> ST2WH.orig_wh_nr;