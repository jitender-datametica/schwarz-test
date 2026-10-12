CREATE OR REPLACE VIEW p_lew_mart_cs.v_ema_base_data_1 (

client_id
,src_country_lidl_cd
,country_desc
,sales_manager_id
,sales_manager_name
,account_manager_id
,account_manager_name
,wh_id
,wh_name
,orig_store_nr
,store_name
,test_store_fg

)
AS

/* ------------------------------------------------------------------ */
/* ----- BEGIN of inner SQL part (equal for all EMA interfaces) ----- */
/* ------------------------------------------------------------------ */
SELECT
  client.client_id               AS client_id
  ,client.src_country_lidl_cd     AS src_country_lidl_cd
  ,cde.country_desc               AS country_desc
  ,org.sales_manager_id           AS sales_manager_id
  ,org.sales_manager_name         AS sales_manager_name
  ,org.account_manager_id         AS account_manager_id
  ,org.account_manager_name       AS account_manager_name
  ,loc_wh.src_wh_id               AS wh_id
  ,loc_wh.loc_name                AS wh_name
  ,loc_st.src_orig_store_nr       AS orig_store_nr
  ,loc_st.loc_name                AS store_name
  ,loc_st_hist.test_store_fg      AS test_store_fg
FROM
(SELECT
   stwh.client_id                                             AS client_id
  ,stwh.loc_sid_store                                         AS loc_sid_store    /* loc_sid from corresponding store */
  ,stwh.loc_sid_wh                                            AS loc_sid_wh       /* loc_sid from corresponding warehouse */
  ,Coalesce(loc_org.sales_manager_id    ,-100)                AS sales_manager_id
  ,Coalesce(loc_org.sales_manager_name  ,'Bezirksleiter')     AS sales_manager_name
  ,Coalesce(loc_org.account_manager_id  ,-1)                  AS account_manager_id
  ,Coalesce(loc_org.account_manager_name,'Vertriebsleiter')   AS account_manager_name
  ,Coalesce(loc_org.general_manager_id  ,-10000)              AS general_manager_id
  ,Coalesce(loc_org.general_manager_name,'Geschaeftsfuehrer') AS general_manager_name
FROM p_lew_bil_ac.v_store_to_warehouse_1 stwh

LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_1  AS loc_org
ON loc_org.client_id = stwh.client_id
AND loc_org.loc_sid_store = stwh.loc_sid_store

WHERE stwh.orig_store_nr <> stwh.orig_wh_nr
AND stwh.dwh_actual_fg = 1
AND stwh.active_fg = 1

) AS org

-- JOIN for warehouse data
INNER JOIN p_lew_core_ac.v_location_1 AS loc_wh
ON  loc_wh.client_id = org.client_id
AND loc_wh.loc_sid = org.loc_sid_wh
AND loc_wh.wh_store_mark = 'B'

-- JOIN for store data
INNER JOIN p_lew_core_ac.v_location_1 AS loc_st
ON  loc_st.client_id = org.client_id
AND loc_st.loc_sid = org.loc_sid_store
AND loc_st.wh_store_mark = 'A'

 -- JOIN for store hist data (used for test_store_fg)
INNER JOIN p_lew_core_ac.v_location_hist_1 AS loc_st_hist
ON  loc_st_hist.client_id = org.client_id
AND loc_st_hist.loc_sid = org.loc_sid_store
AND CURRENT_DATE BETWEEN loc_st_hist.dwh_valid_from AND loc_st_hist.dwh_valid_to

 -- JOIN for selecting country_1 description
INNER JOIN p_lew_core_ac.v_wawi_ref_country_desc_1  AS cde
ON  cde.country_id = org.client_id
AND cde.language_id = 7

-- JOIN for client data
INNER JOIN p_lew_core_ac.v_client_1  AS client
ON  org.client_id = client.client_id

WHERE CURRENT_DATE + 40 >= loc_st.opening_dt
AND loc_st.closing_dt IS NULL

/* ------------------------------------------------------------------ */
/* ------ END of inner SQL part (equal for all EMA interfaces) ------ */
/* ------------------------------------------------------------------ */
;



