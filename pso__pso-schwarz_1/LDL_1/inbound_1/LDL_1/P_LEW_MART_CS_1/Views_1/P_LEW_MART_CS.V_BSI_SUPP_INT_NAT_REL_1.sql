/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BSI_SUPP_INT_NAT_REL_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BSI_SUPP_INT_NAT_REL_1
(
client_id
, country_iso_cd
, sup_sid
, eks_no
, valid_from
, valid_until
, last_refresh
)
AS
   SELECT
   a.client_id                      AS client_id,
   c.src_country_lidl_cd           AS country_iso_cd,
   a.sup_sid                        AS sup_sid,
   a.eks_no                         AS eks_no,
   a.dwh_valid_from                 AS valid_from,
   a.dwh_valid_to                   AS valid_until,
   CURRENT_TIMESTAMP                AS last_refresh
   FROM p_lew_core_ac.v_supplier_eks_hist_1 a
   INNER JOIN p_lew_core_ac.v_client_1 c
   ON a.client_id = c.client_id

   WHERE CURRENT_DATE BETWEEN  a.dwh_valid_from  AND a.dwh_valid_to
   AND a.deleted_fg = 0
   AND a.eks_no > 0
;