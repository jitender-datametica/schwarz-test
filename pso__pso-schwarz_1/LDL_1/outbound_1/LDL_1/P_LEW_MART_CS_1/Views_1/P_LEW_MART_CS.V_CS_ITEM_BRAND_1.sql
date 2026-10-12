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
#  1.2  04.11.2019    Wieber.Harald            Update LDL.2.0
#  1.3  19.12.2019    Wieber.Harald            Update
#  1.4  22.01.2020    Wieber,Harald            Erweiterung APT
#  1.5  02.06.2020    Doehla,Kay               dwh_load_id hinzugefuegt
#  1.6  26.10.2020    Ross, Ulrich             add column supplier_id, item_id
#  1.7  29.01.2021    Ross, Ulrich             Add group by while changing v_mat_gen_item_asis_1 for ItemStatus_cd
#  1.8  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.9  14.04.2021    Ross, Ulrich             Add COALESCE(sup.src_supplier_id, sup.sup_sid) to get the sup_sid for eLWIS countries
#                                              https://jira.schwarz/browse/DDLE-2086
#  1.10 17.09.2021    Ross, Ulrich             Add View v_client_migration_per_1 in UNION to get Infos wich country_1 in migrated to WAWI
#----------------------------------------------------------------------------

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_brand_1 (client_id, wh_id, orig_item_nr, item_id, case_size,
supplier_id, orig_supplier_nr, brand_name, country_iso_cd, valid_from, valid_until, dwh_updated, dwh_created,
dwh_load_id, load_id, src_id, last_refresh) AS -- Remove records completely in the future.
 SELECT A.client_id,
 pinfo.wh_id,
 A.orig_item_nr,
 A.item_sid AS item_id,
 A.case_size,
 COALESCE(SUP.src_supplier_id, SUP.sup_sid) AS supplier_id,
 COALESCE(ROUND(SAFE_CAST(SUP.src_orig_supplier_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(SUP.src_lifnr AS BIGNUMERIC), 0)
  , 0) AS orig_supplier_nr,
 A.brand_name,
 A.src_country_lidl_cd AS country_iso_cd,
 pinfo.valid_from,
 pinfo.valid_until,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id,
 CURRENT_DATE AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_item_asis_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS B ON A.client_id = B.client_id AND A.item_sid = B.item_sid AND CURRENT_DATE
   BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS WAWI ON A.client_id = WAWI.client_id AND A.item_sid = WAWI.item_sid
 LEFT JOIN (SELECT PHH.client_id,
    PHH.item_sid,
    COALESCE(LOC.src_wh_id, PDH.loc_sid) AS wh_id,
    PHH.sup_sid,
     CASE
     WHEN PDH.dwh_valid_from > PHH.dwh_valid_from
     THEN PDH.dwh_valid_from
     ELSE PHH.dwh_valid_from
     END AS valid_from,
     CASE
     WHEN PDH.dwh_valid_to < PHH.dwh_valid_to
     THEN PDH.dwh_valid_to
     ELSE PHH.dwh_valid_to
     END AS valid_until
   FROM ldl_p_lew_core_ac.v_pinfo_header_hist_1 AS PHH
    INNER JOIN ldl_p_lew_core_ac.v_pinfo_detail_hist_1 AS PDH ON PHH.client_id = PDH.client_id AND PHH.pinfo_sid = PDH.pinfo_sid
         AND CURRENT_DATE BETWEEN PDH.dwh_valid_from AND PDH.dwh_valid_to AND PDH.deleted_fg = 0
    INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON PDH.client_id = LOC.client_id AND PDH.loc_sid = LOC.loc_sid AND
      LOC.wh_store_mark = 'B'
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CMP ON PDH.client_id = CMP.client_id AND CMP.active_fg = 1
   WHERE CURRENT_DATE BETWEEN PHH.dwh_valid_from AND PHH.dwh_valid_to
    AND PHH.deleted_fg = 0
    AND CASE
      WHEN PDH.dwh_valid_from > PHH.dwh_valid_from
      THEN PDH.dwh_valid_from
      ELSE PHH.dwh_valid_from
      END <= CURRENT_DATE
    AND PHH.sup_sid IS NOT NULL
   UNION DISTINCT
   SELECT WAWI.client_id,
    WAWI.item_sid,
    COALESCE(LOC.src_wh_id, LOC.loc_sid) AS wh_id,
    WAWI.sup_sid,
    WAWI.dat_rec_start AS valid_from,
    WAWI.dat_rec_end AS valid_until
   FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_data_1 AS WAWI
    INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON WAWI.client_id = LOC.client_id AND WAWI.wh_loc_sid = LOC.loc_sid)
 AS pinfo ON A.client_id = pinfo.client_id AND A.item_sid = pinfo.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_supplier_1 AS SUP ON pinfo.client_id = SUP.client_id AND pinfo.sup_sid = SUP.sup_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_item_brand_asis_1 AS IBR ON A.client_id = IBR.client_id AND A.item_sid = IBR.item_sid
WHERE A.brand_name IS NOT NULL
 AND CURRENT_DATE BETWEEN A.valid_from AND A.valid_until
 AND CURRENT_DATE BETWEEN pinfo.valid_from AND pinfo.valid_until
GROUP BY A.client_id,
 pinfo.wh_id,
 A.orig_item_nr,
 item_id,
 A.case_size,
 supplier_id,
 orig_supplier_nr,
 A.brand_name,
 country_iso_cd,
 pinfo.valid_from,
 pinfo.valid_until,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id,
 load_id,
 src_id,
 last_refresh;