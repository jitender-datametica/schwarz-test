/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_supplier_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.3  31.08.2021    Ulrich, Ross                 Change valid_from and Valid_until to MAX and MIN
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_supplier_1
(
  client_id,
  country_iso_cd,
  orig_supplier_nr,
  valid_from,
  valid_until,
  sup_name,
  dwh_updated,
  dwh_created,
  dwh_load_id,
  load_id,
  src_id
)
AS
SELECT 
    erg.client_id,
    erg.country_iso_cd,
    erg.orig_supplier_nr,
    erg.valid_from,
    erg.valid_until,
    erg.sup_name,
    erg.dwh_updated,
    erg.dwh_created,
    erg.dwh_load_id,
    erg.load_id,
    erg.src_id
FROM
    (SELECT
        sup.client_id,
        sup.country_iso_cd,
        sup.orig_supplier_nr,
        MIN(sup.valid_from) AS valid_from,
        MAX(sup.valid_until) AS valid_until,
        sup.sup_name,
        MIN(sup.dwh_updated) AS dwh_updated,
        MAX(sup.dwh_created) AS dwh_created,
        MAX(sup.dwh_load_id) AS dwh_load_id,
        MAX(sup.load_id) AS load_id,
        sup.src_id
    FROM p_lew_mart_cs.v_cs_item_supplier_1 AS sup
    INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 AS asis
    ON sup.client_id = asis.client_id AND sup.item_id = asis.item_sid
    WHERE sup.orig_supplier_nr > 0
        AND CURRENT_DATE BETWEEN sup.valid_from AND sup.valid_until
        AND asis.itemstatus_cd > 3
        AND asis.itemstatus_cd < 10
        AND asis.buying_list_type_id IS NOT NULL
        AND asis.buying_list_type_id > 0
    GROUP BY 1,2,3,6,11
    ) AS erg
    
    QUALIFY ROW_NUMBER() OVER (PARTITION BY erg.client_id, erg.orig_supplier_nr ORDER BY erg.valid_from ASC NULLS LAST, erg.valid_until DESC NULLS LAST, erg.dwh_load_id DESC NULLS LAST, erg.load_id DESC NULLS LAST, erg.sup_name DESC NULLS LAST) = 1 
;

