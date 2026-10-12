/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------

# $LastChangedBy: gueneso
# $LastChangedDate: 2021-03-17 
# 
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  20.08.2020    Ulrich, Ross            First Version
#  1.1  22.02.2021    Ulrich, Ross            Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id
#  1.2  05.03.2021    Ulrich, Ross            Change source from v_gen_item_hist_2 to v_gen_item_asis_2 (missing values)
#----------------------------------------------------------------------------
#  1.3  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.4  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jira.schwarz/browse/DDLE-1994
#  1.5  07.04.2021    Guenes, Oguzhan              Fix for employee_name filter
#                                                  https://jira.schwarz/browse/DDLE-2047
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_buying_emp_2 COMMENT ='$Revision: 16786 $ Generaliesierte View; Input für CS Views; Bereich Artikel_2 Gesellschfts Zuordnung'
(
client_id
, country_iso_cd
, buying_employee_skey
, buying_employee_name
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
   SELECT
   b.client_id,
   b.src_country_lidl_cd   AS country_iso_cd,
   b.buyer_id            AS buying_employee_skey,
   b.buying_employee_name,
   b.dwh_updated,
   b.dwh_created,
   b.dwh_load_id,
   b.load_id,
   b.src_id
   FROM
   (SELECT DISTINCT
   a.client_id,
   src_country_lidl_cd,
   CASE
              WHEN  is_real(TO_VARIANT(a.buying_employee_name)) and TO_NUMBER(a.buying_employee_name)>=0
              AND a.buying_employee_name BETWEEN '0' AND '999999'
              THEN TO_NUMBER(a.buying_employee_name)
   ELSE a.buying_employee_skey
 END AS buyer_id,
   a.buying_employee_name,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   -1 as load_id,
   0 as src_id
   FROM p_lew_mart_cs.v_gen_item_asis_2 a
        WHERE a.item_sid  > 0
          AND a.buying_employee_name   IS NOT NULL
          AND a.itemstatus_cd > 3
          AND a.itemstatus_cd < 10
          AND a.buying_list_type_id IS NOT NULL
          AND a.buying_list_type_id > 0
          AND a.case_size_lago > 0 
   QUALIFY ROW_NUMBER () OVER (PARTITION BY a.client_id, buyer_id ORDER BY a.dwh_load_id, a.valid_from DESC NULLS LAST) = 1
   ) b;


