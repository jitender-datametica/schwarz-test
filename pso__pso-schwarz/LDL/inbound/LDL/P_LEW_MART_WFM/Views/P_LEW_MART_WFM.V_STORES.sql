CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORES
(
     COUNTRY_LIDL_CD
    ,WH_ID
    ,CLOSED_FG
    ,ORIG_STORE_NR
    ,MDE_LANG_CD
    ,SALES_MANAGER_ID
    ,QTY_MIN_DFLT
    ,STORE_DESC
    ,REGION_CD
    ,DAT_OPENING
    ,DAT_CLOSING
    ,DAT_VALID_FROM
    ,DAT_OPENING_OVIS
    ,DAT_CLOSING_OVIS
    ,DAT_REAL_OPENING
    ,ORD_UNIT_VALID_STORE_CD
    ,LONGITUDE
    ,LATITUDE
    ,ZIP_CODE
    ,CITY
    ,STREET
    ,HOUSE_NUMBER
) AS
SELECT
cntry.src_country_lidl_cd AS country_lidl_cd
,st2wh.orig_wh_nr          AS wh_id
,w.closed_fg               AS closed_fg
,COALESCE(st2wh.orig_store_nr,  loc.src_orig_store_nr) AS orig_store_nr
,w.mde_lang_cd             AS mde_lang_cd
,COALESCE(org.sales_manager_id, -100)                  AS sales_manager_id
,w.qty_min_dflt            AS qty_min_dflt
,loc.loc_name              AS store_desc
,NULL                      AS region_cd
,loc.opening_dt            AS dat_opening
,loc.closing_dt            AS dat_closing
,w.dat_valid_from          AS dat_valid_from
,w.dat_opening_ovis        AS dat_opening_ovis
,w.dat_closing_ovis        AS dat_closing_ovis
,loc.real_opening_dt       AS dat_real_opening
,w.ord_unit_valid_store_cd AS ord_unit_valid_store_cd
,loc.longitude             AS longitude
,loc.latitude              AS latitude
,adr.zip_code              AS zip_code
,adr.city                  AS city
,adr.street                AS street
,adr.house_number1         AS house_number
FROM p_lew_core_ac.v_location loc

/* for the region_cd, test_store_fg */
INNER JOIN p_lew_core_ac.v_location_hist loc_hist
ON loc.loc_sid = loc_hist.loc_sid
AND loc_hist.deleted_fg = 0
AND CURRENT_DATE BETWEEN loc_hist.dwh_valid_from AND loc_hist.dwh_valid_to

INNER JOIN p_lew_core_ac.v_country cntry
ON loc.client_id = cntry.country_sid

INNER JOIN p_lew_bil_ac.v_store_to_warehouse st2wh
ON loc.client_id = st2wh.client_id
AND loc.loc_sid = st2wh.loc_sid_store
AND CURRENT_DATE BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to

/* for sales_manager_id */
LEFT OUTER JOIN p_lew_core_ac.v_location_organization_hist org
ON loc.client_id = org.client_id
AND loc.loc_sid = org.loc_sid
AND org.deleted_fg = 0
AND CURRENT_DATE BETWEEN org.dwh_valid_from AND org.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store w
ON loc.client_id = w.client_id
AND loc.loc_sid = w.st_loc_sid
AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end

/* for address details */
LEFT OUTER JOIN p_lew_core.t_address adr
ON adr.addr_sid = loc_hist.addr_sid

WHERE loc.wh_store_mark = 'A'                    /* stores */
/* Only select opend stores resp. stores which open in the next 14 days */
AND CURRENT_DATE + 84 > loc.opening_dt
--AND loc_hist.test_store_fg <> 1                  /* Exclude test stores   */
AND (loc_hist.test_store_fg = 0 OR loc_hist.test_store_fg IS NULL) /* Exclude test stores   */
AND (loc.closing_dt IS NULL
OR CAST(loc.closing_dt AS DATE) > CURRENT_DATE) /* Exclude closed stores */
/* Exclude stores which represent a warehouse 
AND (loc.client_id, loc.src_orig_store_nr) NOT IN (SELECT
client_id, src_wh_id
FROM p_lew_core_ac.v_location
   WHERE CURRENT_DATE > opening_dt
   AND wh_store_mark = 'B') */
AND st2wh.orig_store_nr <> st2wh.orig_wh_nr
;