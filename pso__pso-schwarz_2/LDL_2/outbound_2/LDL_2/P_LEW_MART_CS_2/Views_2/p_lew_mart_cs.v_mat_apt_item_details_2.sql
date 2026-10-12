/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_DETAILS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  15.09.2021    Ross, Uli                    Change ORDER_BY in QUALIFY, add itemstatus_cd to get the highest itemstatus_cd
#                                                  https://jira.schwarz/browse/DDLE-2611
#  1.2  10.12.2021    Ao, Lin                      Change Regex for packageunit_type
#                                                  https://jira.schwarz/browse/DDLE-3842
#  1.3  23.06.2022    Ross, Uli                    User Story 3407772
#                                                  Add ITEMSTATUS_CD = 10
#  1.4  16.08.2022    Ross, Uli                    User Story 363377
#                                                  Add column weight_fg
#  1.5  11.06.2024    Ross, Uli                    User Story 635594
#                                                  Add column brand_type_desc
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_details_2 (client_id, country_iso_cd, org_item_nr, valid_from_item
, case_size, buying_emp_nat_name, dat_rec_start, dat_rec_end, brand_name, itemlistingtype_cd, vat_no, packageunit_size,
packageunit_type, packagetype_descr, palletfactor_euro, int_item_nr, itemstatus_cd, weight_fg, brand_type_desc,
dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT I.client_id,
 I.src_country_lidl_cd AS country_iso_cd,
 I.orig_item_nr AS org_item_nr,
 I.valid_from AS valid_from_item,
 I.case_size,
  CASE
  WHEN LOWER(I.buying_employee_name) = 'NA'
  THEN NULL
  ELSE I.buying_employee_name
  END AS buying_emp_nat_name,
 I.valid_from AS dat_rec_start,
 I.valid_until AS dat_rec_end,
 I.brand_name,
 I.buying_list_type_id AS itemlistingtype_cd,
 I.vat_id AS vat_no,
 I.unitsize AS packageunit_size,
 REGEXP_EXTRACT(COLLATE(I.unitsize, ''), '(?i)[^0-9]+$') AS packageunit_type,
 I.packagetype_desc AS packagetype_descr,
  CASE
  WHEN I.case_euro = - 1
  THEN 0
  ELSE I.case_euro
  END AS palletfactor_euro,
 I.orig_item_nr_int AS int_item_nr,
 I.itemstatus_cd,
 IFNULL(I.weight_fg, 0) AS weight_fg,
 REFLIST.brand_type_desc,
 I.dwh_updated,
 I.dwh_created,
 I.dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2 AS REFLIST ON I.client_id = REFLIST.language_id AND I.buying_list_type_id
    = REFLIST.buying_list_type_id
WHERE I.case_size_lago > 0
 AND (I.itemstatus_cd > 3 AND I.itemstatus_cd < 11)
 AND I.buying_list_type_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), org_item_nr, I.valid_from, CAST(I.case_size AS STRING)
      ORDER BY I.itemstatus_cd IS NULL, I.itemstatus_cd, I.dwh_load_id IS NULL, I.dwh_load_id, I.brand_name IS NULL, I.brand_name
      )) = 1;