/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_wh_2 (client_id, wh_id, type_id, loc_name, closing_dt, opening_dt, company,
street, zip_code, city, country_iso_cd, dwh_valid_from, dwh_valid_to) AS SELECT LCTN.client_id,
 LCTN.src_wh_id AS wh_id,
 wh_type.type_id,
 LCTN.loc_name,
 LCTN.closing_dt,
 LCTN.opening_dt,
 COALESCE(c_so.comp_name, c_po.comp_name, '<unknown>') AS company,
 COALESCE(ADDR.street, '<unknown>') AS street,
 COALESCE(ADDR.zip_code, '<unknown>') AS zip_code,
 COALESCE(ADDR.city, '<unknown>') AS city,
 T.src_country_lidl_cd AS country_iso_cd,
 LCTN_H.dwh_valid_from,
 LCTN_H.dwh_valid_to
FROM ldl_p_lew_core_ac.v_location_2 AS LCTN
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LCTN_H ON LCTN.loc_sid = LCTN_H.loc_sid
 LEFT JOIN ldl_p_lew_core_ac.v_address_2 AS ADDR ON LCTN_H.client_id = ADDR.client_id AND LCTN_H.addr_sid = ADDR.addr_sid
 LEFT JOIN (SELECT SO.client_id,
   SO.sales_org_sid,
   CO.comp_name
  FROM ldl_p_lew_core_ac.v_sales_org_2 AS SO
   INNER JOIN ldl_p_lew_core_ac.v_company_2 AS CO ON SO.client_id = CO.client_id AND SO.comp_sid = CO.comp_sid) AS c_so ON
   LCTN_H.client_id = c_so.client_id AND LCTN_H.sales_org_sid = c_so.sales_org_sid
 LEFT JOIN (SELECT PO.client_id,
   PO.pur_org_sid,
   CO0.comp_name
  FROM ldl_p_lew_core_ac.v_purchase_org_2 AS PO
   INNER JOIN ldl_p_lew_core_ac.v_company_2 AS CO0 ON PO.client_id = CO0.client_id AND PO.comp_sid = CO0.comp_sid) AS c_po
 ON LCTN_H.client_id = c_po.client_id AND LCTN_H.pur_org_sid = c_po.pur_org_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS C ON LCTN_H.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS T ON C.country_sid = T.country_sid
 LEFT JOIN (SELECT WHS.client_id,
   WHS.wh_loc_sid,
   type_ids.type_id
  FROM ldl_p_lew_core_ac.v_wawi_org_wh_2 AS WHS
   LEFT JOIN (SELECT 1 AS type_id
     UNION ALL
     SELECT 3 AS type_id
     UNION ALL
     SELECT 4 AS type_id
     UNION ALL
     SELECT 5 AS type_id) AS type_ids ON type_ids.type_id = 1 AND WHS.distribute_wh_fg = 1 OR type_ids.type_id = 3 AND
        WHS.prop_wh_fg = 1 OR type_ids.type_id = 4 AND WHS.sales_wh_fg = 1 OR type_ids.type_id = 5 AND WHS.supp_wh_fg =
      1) AS wh_type ON LCTN_H.client_id = wh_type.client_id AND LCTN_H.loc_sid = wh_type.wh_loc_sid
WHERE UPPER(LCTN.wh_store_mark) = 'B'
 AND LCTN_H.deleted_fg = 0
 AND LCTN.src_wh_id > 0;