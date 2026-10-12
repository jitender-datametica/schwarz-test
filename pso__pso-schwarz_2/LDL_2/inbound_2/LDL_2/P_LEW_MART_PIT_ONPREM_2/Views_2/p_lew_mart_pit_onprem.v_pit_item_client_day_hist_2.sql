CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEM_CLIENT_DAY_HIST_2
(
     client_id

   , dwh_cal_dt

   , cy_year
   , cy_month
   , iso_year_week
   , adv_week_id
   , lang_sid
   , weekday_nr

   , weekday_descr
   , weekday_sdescr
   , dwh_cal_dt_ldescr

   , cy_month_descr

   , item_sid

   , item_mstr_sid

   , item_fam_grp_sid -- uwg_af_sid
   , brand_sid
   , sub_item_grp_sid --uwg_sid
   , item_grp_int_sid --wgi_sid

   , orig_item_nr
   , item_descr_int
   , item_descr

   , item_variant_descr_int
   , item_variant_descr

   , src_familygrp_id --uwg_af_id
   , src_familygrp_cd --uwg_af_cd
   , item_fam_grp_name --uwg_af_desc_int
   , item_fam_grp_descr --uwg_af_desc_loc

   , src_subitemgrp_id --uwg_id
   , src_subitemgrp_cd --uwg_cd
   , sub_item_grp_name --uwg_desc_int

   , src_itemgrp_int_id --wgi_id
   , src_itemgrp_int_cd --wgi_cd
   , item_grp_int_name --wgi_desc_int
   , item_grp_int_descr --wgi_desc_loc

   , brand_name_int
   , brand_descr

   , buying_list_type_id
   , buying_list_type_descr
   , buying_list_type_group_id
   , buying_list_type_group_descr

   , listing_type_id
   , listing_type_descr
   , listing_type_group_id
   , listing_type_group_descr
   , listing_fg

   , action_type_id
   , marke_em_descr
   , case_size
   , marke_fg
   , em_fg
      )
AS
(SELECT
Icd.client_id                           AS client_id
,Icd.dwh_cal_dt                          AS dwh_cal_dt
,Icd.cy_year
,Icd.cy_month
,Icd.cy_week                              AS iso_year_week -- ::= Iso Week AND Year
                                                       
,Icd.adv_week_id                         AS adv_week_id
,Icd.lang_sid                             AS lang_sid
--TD_Day_of_Week ( Icd.DWH_CAL_DT )        AS weekday_nr
--DATE_part('DayOFWeek',Icd.DWH_CAL_DT::DATE ) + 1 As weekday_nr 
,DATE_part('DayOFWeekiso',Icd.DWH_CAL_DT::DATE ) As weekday_nr

--Icd.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4' REMOVED. ***/:: CHAR ( 22)
--AS weekday_descr
,TO_CHAR(Icd.dwh_cal_dt::DATE, 'DY' )           AS weekday_descr       -- first 2 chars of the weekday description AS short description
--SUBSTR ( weekday_descr, 1, 2 )           AS weekday_sdescr        -- first 2 chars of the weekday description AS short description
,TO_CHAR(Icd.dwh_cal_dt::DATE, 'DY' )           AS weekday_sdescr        -- first 2 chars of the weekday description AS short description
--,Icd.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4,BMMMMBDD,BYYYY' REMOVED. ***/:: CHAR ( 22)
,TO_CHAR(Icd.dwh_cal_dt::DATE, 'DY, MON DD , YYYY') AS dwh_cal_dt_ldescr
--TO_VARCHAR(CAST((cy_month/100) AS VARCHAR(4)) || '-' || CAST(  ( cy_month MOD 100 ) AS VARCHAR(2)) || '-' || CAST( 1 AS VARCHAR(2)), '') AS cy_month_descr
-- substr(TO_CHAR(cy_month),1,4) || '-' || TO_CHAR(mod(cy_month, 100),'09') || '01'  AS cy_month_descr, 
,TO_CHAR(Icd.dwh_cal_dt ::DATE, 'MON-YYYY') AS cy_month_descr
,Icd.item_sid                        AS item_sid
,Icd.item_mstr_sid                   AS item_mstr_sid
,Icd.item_fam_grp_sid                AS item_fam_grp_sid -- uwg_af_sid
,Icd.brand_sid                       AS brand_sid
,Icd.sub_item_grp_sid                AS sub_item_grp_sid --uwg_sid
,Icd.item_grp_int_sid                AS item_grp_int_sid --wgi_sid
,Icd.orig_item_nr                    AS orig_item_nr
,Icd.item_name                       AS item_descr_int
,COALESCE ( Icd.item_description, Icd.item_name )                                                     AS item_descr
,Icd.item_name         || ' (' || TO_CHAR ( TO_NUMBER(Icd.case_size) ) || ')'                                     AS item_variant_descr_int
,COALESCE ( Icd.item_description, Icd.item_name )     || ' (' || TO_CHAR ( TO_NUMBER(Icd.case_size) ) || ')'      AS item_variant_descr
,Icd.src_familygrp_id                AS src_familygrp_id --uwg_af_id
,Icd.src_familygrp_cd                AS src_familygrp_cd --uwg_af_cd
,Icd.item_fam_grp_name               AS item_fam_grp_name --uwg_af_desc_int
,Icd.item_fam_grp_descr              AS item_fam_grp_descr --uwg_af_desc_loc
,Icd.src_subitemgrp_id               AS src_subitemgrp_id --uwg_id
,Icd.src_subitemgrp_cd               AS src_subitemgrp_cd --uwg_cd
,Icd.sub_item_grp_name               AS sub_item_grp_name --uwg_desc_int
,Icd.src_itemgrp_int_id              AS src_itemgrp_int_id --wgi_id
,Icd.src_itemgrp_int_cd              AS src_itemgrp_int_cd --wgi_cd
,Icd.item_grp_int_name               AS item_grp_int_name --wgi_desc_int
,Icd.item_grp_int_descr              AS item_grp_int_descr --wgi_desc_loc
,Icd.brand_name                      AS brand_name_int
,Icd.brand_descr                     AS brand_descr
,Icd.buying_list_type_id             AS buying_list_type_id
,Icd.buying_list_type_descr          AS buying_list_type_descr
,Icd.buying_list_type_group_id       AS buying_list_type_group_id
,Icd.buying_list_type_group_descr    AS buying_list_type_group_descr
,Icd.listing_type_id                 AS listing_type_id
,Icd.listing_type_descr              AS listing_type_descr
,Icd.listing_type_group_id           AS listing_type_group_id
,Icd.listing_type_group_descr        AS listing_type_group_descr
,Icd.listing_fg                      AS listing_fg
,Icd.action_type_id                  AS action_type_id
,Icd.derived_brand_type_cd           AS marke_em_descr
,Icd.case_size                       AS case_size
,CASE WHEN Icd.buying_list_type_id IN  ( 1,3,5,7,9,11 )  -- 1 indicates Marke could be used for SUM 
            THEN CAST( 1 AS INTEGER)
ELSE CAST( 0 AS INTEGER)
END                                  AS marke_fg
,CASE WHEN Icd.buying_list_type_id NOT IN  ( 1,3,5,7,9,11 )  -- 1 indicates EM could be used for SUM
            THEN CAST( 1 AS INTEGER)
ELSE CAST( 0 AS INTEGER)
END                                 AS em_fg
FROM

(SELECT
itm.*
FROM p_lew_mart_pit_onprem.t_pit_item_client_day_2 itm WHERE 1=1 AND action_type_id IN (1,2,3) )  Icd
);