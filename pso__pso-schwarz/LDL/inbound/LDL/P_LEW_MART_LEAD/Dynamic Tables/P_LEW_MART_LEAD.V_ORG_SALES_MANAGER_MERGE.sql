CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ORG_SALES_MANAGER_MERGE
(
  aspect_id
, client_id
, wh_id
, wh_id_exp
, loc_sid_wh
, sales_manager_id
, account_manager_id
, sales_manager_name
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
   osmm.aspect_id,
   osmm.client_id,
   b.src_wh_id AS wh_id,
   bexp.src_wh_id AS wh_id_exp,
   b.loc_sid AS loc_sid_wh,
   osmm.sales_manager_id,
   osmm.account_manager_id,
   osmm.sales_manager_name
   FROM p_lew_core_ac.v_wawi_org_sales_manager_merge_act AS osmm
   INNER JOIN p_lew_core_ac.v_location AS b
   ON osmm.client_id = b.client_id
   AND osmm.wh_loc_sid = b.loc_sid
   AND b.wh_store_mark = 'B'  -- Filialen
   INNER JOIN p_lew_core_ac.v_location AS bexp
   ON osmm.client_id = bexp.client_id
   AND osmm.wh_loc_sid_exp = bexp.loc_sid
   AND bexp.wh_store_mark = 'B'  -- Filialen
   -- Filialen
   UNION ALL
   /* Adding country level dummy records for aspect id 1 and 2*/
   SELECT
   aspt.aspect_id                                   AS aspect_id,
   client_id                                        AS client_id,
   -1*client_id                                     AS wh_id,
   -1*client_id                                     AS wh_id_exp,
   -1*client_id                                     AS loc_sid_wh,
   -1*client_id                                     AS sales_manager_id,
   -1*client_id                                     AS account_manager_id,
   '#'|| TRIM( cntr.country_iso_cd)
   AS sales_manager_name
   FROM p_lew_core_ac.v_wawi_ref_client_country              AS clnt
   INNER JOIN p_lew_core_ac.v_wawi_ref_country               AS cntr
   ON clnt.country_id = cntr.country_id
   CROSS JOIN p_lew_mart_lead.v_ref_aspect                   AS aspt
   WHERE cntr.dashboard_relevant_fg = 1
;
