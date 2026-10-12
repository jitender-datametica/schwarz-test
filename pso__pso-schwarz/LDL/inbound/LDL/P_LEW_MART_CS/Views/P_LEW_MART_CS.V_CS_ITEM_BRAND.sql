/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_cs_item_brand.sql 16592 2021-02-01 09:31:52Z uross $
# $Revision: 16592 $
# $LastChangedBy: uross $
# $LastChangedDate: 2021-02-01 10:31:52 +0100 (Mo, 01 Feb 2021) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_cs_item_brand.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  28.08.2019    Wieber.Harald            Rename of the view
#  1.1  28.10.2019    Wieber.Harald            Update Version 2.1
#  1.2  04.11.2019    Wieber.Harald            Update 2.0
#  1.3  19.12.2019    Wieber.Harald            Update
#  1.4  22.01.2020    Wieber,Harald            Erweiterung APT
#  1.5  02.06.2020    Doehla,Kay               dwh_load_id hinzugefuegt
#  1.6  26.10.2020    Ross, Ulrich             add column supplier_id, item_id
#  1.7  29.01.2021    Ross, Ulrich             Add group by while changing v_mat_gen_item_asis for ItemStatus_cd
#  1.8  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.9  14.04.2021    Ross, Ulrich             Add COALESCE(sup.src_supplier_id, sup.sup_sid) to get the sup_sid for eLWIS countries
#                                              https://jira.schwarz/browse/DDLE-2086
#  1.10 17.09.2021    Ross, Ulrich             Add View v_client_migration_per in UNION to get Infos wich country in migrated to WAWI
#----------------------------------------------------------------------------

*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_BRAND
(
    client_id
    , wh_id
    , orig_item_nr
    , item_id
    , case_size
    , supplier_id
    , orig_supplier_nr
    , brand_name
    , country_iso_cd
    , valid_from
    , valid_until
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
    , src_id
    , last_refresh
)
AS
SELECT
    a.client_id                                             AS client_id
    , pinfo.wh_id                                           AS wh_id
    , a.orig_item_nr                                        AS orig_item_nr
    , a.item_sid                                            AS item_id
    , a.case_size                                           AS case_size
    , COALESCE(sup.src_supplier_id, sup.sup_sid)            AS supplier_id
    , COALESCE(TRY_CAST(sup.src_orig_supplier_nr AS INTEGER), TRY_CAST(sup.src_lifnr AS INTEGER),0) AS orig_supplier_nr
    , a.brand_name                                          AS brand_name
    , a.src_country_lidl_cd                                 AS country_iso_cd
    , pinfo.valid_from
    , pinfo.valid_until
    , a.dwh_updated                                         AS dwh_updated
    , a.dwh_created                                         AS dwh_created
    , a.dwh_load_id                                         AS dwh_load_id
    , CAST(-1 AS INTEGER)                                   AS load_id
    , 2                                                     AS src_id
    , CURRENT_DATE                                          AS last_refresh
FROM P_LEW_MART_CS.v_gen_item_asis AS a

INNER JOIN P_LEW_CORE_AC.v_item_hist AS b
ON b.client_id = a.client_id
AND b.item_sid = a.item_sid
AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
  
LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS wawi
ON wawi.client_id = a.client_id
AND wawi.item_sid = a.item_sid

LEFT OUTER JOIN (SELECT
                     phh.client_id
                     , phh.item_sid
                     , COALESCE(loc.src_wh_id, pdh.loc_sid)  AS wh_id
                     , phh.sup_sid
                     , CASE
                         WHEN pdh.dwh_valid_from > phh.dwh_valid_from 
                         THEN pdh.dwh_valid_from
                         ELSE phh.dwh_valid_from
                       END                                                                                  AS valid_from
                     , CASE
                         WHEN pdh.dwh_valid_to < phh.dwh_valid_to 
                         THEN pdh.dwh_valid_to
                         ELSE phh.dwh_valid_to
                       END                                                                                  AS valid_until
                 FROM P_LEW_CORE_AC.v_pinfo_header_hist phh
                 
                 INNER JOIN P_LEW_CORE_AC.v_pinfo_detail_hist pdh
                 ON phh.client_id = pdh.client_id
                 AND phh.pinfo_sid = pdh.pinfo_sid
                 AND CURRENT_DATE BETWEEN pdh.dwh_valid_from  AND pdh.dwh_valid_to
                 AND pdh.deleted_fg = 0
                 
                 INNER JOIN P_LEW_CORE_AC.v_location loc
                 ON pdh.client_id = loc.client_id
                 AND pdh.loc_sid = loc.loc_sid
                 AND loc.wh_store_mark = 'B'

                 INNER JOIN P_LEW_CORE_AC.v_client_migration_per AS cmp
                 ON pdh.client_id = cmp.client_id
                 AND active_fg = 1                 
                 
                 WHERE CURRENT_DATE BETWEEN phh.dwh_valid_from  AND phh.dwh_valid_to
                 AND phh.deleted_fg = 0
                 AND phh.sup_sid IS NOT NULL
                 -- Remove records completely in the future.                                            
                 AND valid_from <= CURRENT_DATE

                 UNION
                 
                 SELECT
                     wawi.client_id
                     , wawi.item_sid
                     , Coalesce(loc.src_wh_id, loc.loc_sid)   AS wh_id
                     , wawi.sup_sid
                     , wawi.dat_rec_start                          AS valid_from
                     , wawi.dat_rec_end                            AS valid_until
                 FROM P_LEW_CORE_AC.v_wawi_itm_sup_wh_data wawi
                 
                 INNER JOIN P_LEW_CORE_AC.v_location AS loc
                 ON wawi.client_id = loc.client_id
                 AND wawi.wh_loc_sid = loc.loc_sid
                 ) AS pinfo
ON a.client_id = pinfo.client_id
AND a.item_sid = pinfo.item_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_supplier sup
ON pinfo.client_id = sup.client_id
AND pinfo.sup_sid = sup.sup_sid
LEFT OUTER JOIN P_LEW_BIL_AC.v_item_brand_asis ibr
ON a.client_id = ibr.client_id
AND a.item_sid = ibr.item_sid
WHERE brand_name IS NOT NULL
AND CURRENT_DATE BETWEEN a.valid_from AND a.valid_until
AND CURRENT_DATE BETWEEN pinfo.valid_from AND pinfo.valid_until
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
;

