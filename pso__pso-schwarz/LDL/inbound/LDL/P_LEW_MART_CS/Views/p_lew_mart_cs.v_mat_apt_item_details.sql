/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_DETAILS
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

CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_details(
	  client_id
	, country_iso_cd
	, org_item_nr
	, valid_from_item
	, case_size
	, buying_emp_nat_name
	, dat_rec_start
	, dat_rec_end
	, brand_name
	, itemlistingtype_cd
	, vat_no
	, packageunit_size
	, packageunit_type
	, packagetype_descr
	, palletfactor_euro
	, int_item_nr
	, itemstatus_cd
  , weight_fg
  , brand_type_desc
	, dwh_updated
	, dwh_created
	, dwh_load_id
	, load_id
	, src_id
) AS
SELECT
    i.client_id
  , i.src_country_lidl_cd     AS country_iso_cd
  , i.orig_item_nr
  , i.valid_from              AS valid_from_item
  , i.case_size               AS case_size
  , CASE  WHEN LOWER(i.buying_employee_name) = 'NA'
            THEN NULL
            ELSE i.buying_employee_name
            END               AS buying_emp_nat_name
  , i.valid_from              AS dat_rec_start
  , i.valid_until             AS dat_rec_end
  , i.brand_name
  , i.buying_list_type_id     AS itemlistingtype_cd
  , i.vat_id                  AS vat_no
  , i.unitsize                AS packageunit_size
  , RegExp_Substr(COLLATE(i.unitsize, ''), '[^0-9]+$', 1, 1, 'i') AS packageunit_type
  , i.packagetype_desc        AS packagetype_descr
  , CASE  WHEN i.case_euro = -1
            THEN 0
            ELSE i.case_euro
            END               AS palletfactor_euro
  , i.orig_item_nr_int        AS int_item_nr
  , i.itemstatus_cd           AS itemstatus_cd
  , IFNULL(i.weight_fg,0)     AS weight_fg
  , reflist.brand_type_desc   AS brand_type_desc
  , i.dwh_updated             AS dwh_updated
  , i.dwh_created             AS dwh_created
  , i.dwh_load_id             AS dwh_load_id
  , CAST(-1 AS INTEGER)       AS load_id
  , 2                         AS src_id
FROM p_lew_mart_cs.v_gen_item_asis AS i

LEFT JOIN p_lew_core_ac.v_wawi_ref_itm_list_type AS reflist
        ON i.client_id = reflist.language_id
        AND i.buying_list_type_id = reflist.buying_list_type_id

WHERE i.case_size_lago > 0      --Filter for dataset without case size, because they have no relation to item_descr
    AND i.itemstatus_cd > 3
    AND i.itemstatus_cd < 11
    AND i.buying_list_type_id IS NOT NULL
    AND i.buying_list_type_id > 0

QUALIFY ROW_NUMBER () OVER (PARTITION BY i.client_id, i.orig_item_nr, i.valid_from, i.case_size ORDER BY i.itemstatus_cd DESC NULLS LAST, i.dwh_load_id DESC NULLS LAST, i.brand_name DESC NULLS LAST) = 1
;