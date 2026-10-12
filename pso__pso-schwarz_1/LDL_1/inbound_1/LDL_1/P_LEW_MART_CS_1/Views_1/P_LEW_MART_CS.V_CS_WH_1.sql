/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_WH_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_WH_1
(
client_id
, wh_id
, type_id
, loc_name
, closing_dt
, opening_dt
, company
, street
, zip_code
, city
, country_iso_cd
, dwh_valid_from
, dwh_valid_to
)
AS
SELECT
lctn.client_id,
lctn.src_wh_id               AS wh_id,
wh_type.type_id,
lctn.loc_name,
lctn.closing_dt,
lctn.opening_dt,
COALESCE(c_so.comp_name,c_po.comp_name, '<unknown>') AS company,
COALESCE(addr.street, '<unknown>') AS street,
COALESCE(addr.zip_code, '<unknown>') AS zip_code,
COALESCE(addr.city, '<unknown>') AS city,
t.src_country_lidl_cd         AS country_iso_cd,
lctn_h.dwh_valid_from,
lctn_h.dwh_valid_to
FROM p_lew_core_ac.v_location_1 lctn

INNER JOIN p_lew_core_ac.v_location_hist_1 lctn_h
ON lctn.loc_sid = lctn_h.loc_sid

-- Adresse
LEFT OUTER JOIN p_lew_core_ac.v_address_1 addr
ON lctn_h.client_id = addr.client_id
AND lctn_h.addr_sid = addr.addr_sid

-- Company Sales_1 Org
LEFT OUTER JOIN (SELECT
so.client_id,
so.sales_org_sid,
co.comp_name
FROM p_lew_core_ac.v_sales_org_1 so

INNER JOIN p_lew_core_ac.v_company_1 co
ON so.client_id = co.client_id
AND so.comp_sid = co.comp_sid
) c_so
ON lctn_h.client_id = c_so.client_id
AND lctn_h.sales_org_sid = c_so.sales_org_sid

-- Company Purchase Org
LEFT OUTER JOIN (SELECT
po.client_id,
po.pur_org_sid,
co.comp_name
FROM p_lew_core_ac.v_purchase_org_1 po

INNER JOIN p_lew_core_ac.v_company_1 co
ON po.client_id = co.client_id
AND po.comp_sid = co.comp_sid
) c_po
ON lctn_h.client_id = c_po.client_id
AND lctn_h.pur_org_sid = c_po.pur_org_sid

-- Country_1
INNER JOIN p_lew_core_ac.v_client_1 c
ON lctn_h.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country_1 t
ON c.country_sid = t.country_sid

-- wh_type
LEFT OUTER JOIN (SELECT
whs.client_id,
whs.wh_loc_sid,
type_ids.type_id
FROM p_lew_core_ac.v_wawi_org_wh_1        AS whs


LEFT OUTER JOIN (SELECT
type_id
FROM (SELECT
1 AS type_id) AS x
UNION ALL
SELECT
type_id
FROM (SELECT
3 AS type_id) AS x
                                 UNION ALL
SELECT
type_id
FROM (SELECT
4 AS type_id) AS x
                                 UNION ALL
SELECT
type_id
FROM (SELECT
5 AS type_id) AS x
                                ) AS type_ids
                ON (type_ids.type_id = 1 AND whs.distribute_wh_fg = 1)
                OR (type_ids.type_id = 3 AND whs.prop_wh_fg = 1)
                OR (type_ids.type_id = 4 AND whs.sales_wh_fg = 1)
                OR (type_ids.type_id = 5 AND whs.supp_wh_fg = 1)
                ) wh_type
ON lctn_h.client_id = wh_type.client_id
AND lctn_h.loc_sid = wh_type.wh_loc_sid

WHERE Upper(lctn.wh_store_mark) = 'B'
AND lctn_h.deleted_fg = 0
AND lctn.src_wh_id > 0
;



