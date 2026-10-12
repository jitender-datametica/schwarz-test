/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_buying_emp_item_rel
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2020    Ulrich, Ross            First Version
#  1.1  22.02.2021    Ulrich, Ross            Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id
#  1.2  05.03.2021    Ulrich, Ross            Add view v_lew_mart_cs.v_gen_item_asis as leading view
#  1.3  15.03.2021    Guenes, Oguzhan              Transfer to Snowflake.
#                                                  https://jirasis.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.4  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jirasis.schwarz/browse/DDLE-1994
#  1.5  07.04.2021    Guenes, Oguzhan              Fix for employee_name filter
#                                                  https://jira.schwarz/browse/DDLE-2047
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_buying_emp_item_rel COMMENT ='$Revision: 16786 $ Generaliesierte View; Input für CS Views; Bereich Artikel Gesellschfts Zuordnung;'
(
  client_id
, country_iso_cd
, org_item_nr
, valid_from
, valid_to
, case_size
, dat_rec_start
, dat_rec_end
, buying_employee_skey
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
   SELECT
   asis.client_id                 AS client_id,
   asis.src_country_lidl_cd     AS country_iso_cd,
   asis.orig_item_nr            AS org_item_nr,
   asis.valid_from,
   asis.valid_until             AS valid_to,
   COALESCE(asis.case_size, 1)  AS case_size,
   asis.valid_from              AS dat_rec_start,
   asis.valid_until             AS dat_rec_end,
   CASE
          WHEN is_real(TO_VARIANT(asis.buying_employee_name)) and TO_NUMBER(asis.buying_employee_name)>=0
               AND asis.buying_employee_name BETWEEN '0' AND '99999'
          THEN CAST(asis.buying_employee_name AS INT)
          ELSE asis.buying_employee_skey
        END AS buying_employee_skey,
   asis.dwh_updated,
   asis.dwh_created,
   asis.dwh_load_id,
   -1 as load_id,
   0 as src_id
   FROM p_lew_mart_cs.v_gen_item_asis asis
  
  WHERE CURRENT_DATE BETWEEN asis.valid_from AND asis.valid_until
    AND asis.itemstatus_cd > 3
    AND asis.itemstatus_cd < 10
    AND asis.buying_list_type_id IS NOT NULL
    AND asis.buying_list_type_id > 0
    AND asis.case_size_lago > 0
   GROUP BY asis.client_id, asis.src_country_lidl_cd, asis.orig_item_nr, asis.valid_from, asis.valid_until, asis.case_size, asis.valid_from, asis.valid_until,
     asis.buying_employee_name, asis.buying_employee_skey, asis.dwh_updated, asis.dwh_created, asis.dwh_load_id
   QUALIFY ROW_NUMBER () OVER (PARTITION BY asis.client_id, asis.orig_item_nr, asis.valid_from, asis.case_size, asis.buying_employee_name, asis.buying_employee_skey ORDER BY asis.dwh_load_id DESC NULLS LAST) = 1
   ;