/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.10.2017    -                        corrected CROSS JOIN condition for v_wawi_sup_supplier_2
#  1.2  26.10.2017    -                        corrected where clause
#  1.3  15.11.2017    Wieber.Harald            Release 1.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  2.0  21.01.2021    Michal Malinowski        Added -1 dummy_2 record for supplier_id for each client_id
#                                              PatchNo: 2705, REP3-7970
#----------------------------------------------------------------------------
*/



CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_sup_supplier_2
OPTIONS(DESCRIPTION = '$Revision: 16774 $')
AS
SELECT SUPPLIERH.client_id,
 SUPPLIERH.sup_sid AS supplier_id,
  CASE
  WHEN SUBSTR(SUPPLIERH.src_lifnr, 1, 1) > '9'
  THEN COALESCE(LTRIM(SUPPLIERH.src_orig_supplier_nr), SUPPLIERH.src_lifnr)
  ELSE COALESCE(LTRIM(SUPPLIERH.src_orig_supplier_nr), CAST(ROUND(CAST(SUPPLIERH.src_lifnr AS BIGNUMERIC), 0) AS STRING)
   )
  END AS orig_supplier_nr,
 SUPPLIERH.name1 AS supplier_name,
 SUPPLIERH.sort1 AS supplier_search_name,
 SUPPLIERH.dwh_valid_from AS dat_rec_start,
 SUPPLIERH.dwh_valid_to AS dat_rec_end,
 WAWI.dat_valid_from,
 WAWI.suppliergroup_id,
 WAWI.delivery_item_cd,
 WAWI.vat_id,
 WAWI.order_area_cd,
 WAWI.currency_iso_cd,
 WAWI.invoice_entry_fg,
 WAWI.intercompany_cd,
 WAWI.licence_cd,
 WAWI.title_cd,
 SUPPLIERH.vat_ident_no AS vat_ident_nr,
 WAWI.broken_item_limit,
 WAWI.finance_office,
 WAWI.turnover_cd,
 WAWI.dcw_supplier_nr,
 WAWI.branch_id,
 WAWI.branch_desc,
 WAWI.region_id,
 WAWI.region_desc,
 SUPPLIERH.global_location_nr,
 WAWI.supplier_category_id,
 WAWI.supplier_customer_nr,
 SUPPLIERH.tax_no_1 AS supplier_tax_cd,
 WAWI.supplier_short_nr,
 SUPPLIERH.name2 AS supplier_name2,
 SUPPLIERH.name3 AS supplier_name3,
 WAWI.supplier_text_1,
 WAWI.supplier_text_2,
 WAWI.supplier_text_3,
 WAWI.supplier_text_4,
 WAWI.supplier_text_5,
 SUPPLIERH.main_negot_cntry_cd,
 SUPPLIERH.country_cd_conegot AS agg_co_negot_cntry_cd,
 SUPPLIERH.supplier_id_int
FROM ldl_p_lew_bil_ac.v_supplier_2 AS SUPPLIERH
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_sup_supplier_2 AS WAWI ON SUPPLIERH.client_id = WAWI.client_id AND SUPPLIERH.sup_sid =
    WAWI.sup_sid AND CURRENT_DATE BETWEEN WAWI.dat_rec_start AND WAWI.dat_rec_end
   /* Eingrenzen auf gueltige wawi Datensaetze */
WHERE SUPPLIERH.actual_fg_supplier = 1 /* Eingrenzen auf gueltige Supplier_2 */
UNION ALL
SELECT client_id,
 - 1 AS supplier_id,
 CAST(NULL AS STRING) AS orig_supplier_nr,
 CAST(NULL AS STRING) AS supplier_name,
 CAST(NULL AS STRING) AS supplier_search_name,
 DATE(NULL) AS dat_rec_start,
 DATE(NULL) AS dat_rec_end,
 DATE(NULL) AS dat_valid_from,
 CAST(NULL AS BIGNUMERIC) AS suppliergroup_id,
 CAST(NULL AS STRING) AS delivery_item_cd,
 CAST(NULL AS BIGNUMERIC) AS vat_id,
 CAST(NULL AS STRING) AS order_area_cd,
 CAST(NULL AS STRING) AS currency_iso_cd,
 CAST(NULL AS BIGNUMERIC) AS invoice_entry_fg,
 CAST(NULL AS BIGNUMERIC) AS intercompany_cd,
 CAST(NULL AS STRING) AS licence_cd,
 CAST(NULL AS BIGNUMERIC) AS title_cd,
 CAST(NULL AS STRING) AS vat_ident_nr,
 CAST(NULL AS BIGNUMERIC) AS broken_item_limit,
 CAST(NULL AS STRING) AS finance_office,
 CAST(NULL AS BIGNUMERIC) AS turnover_cd,
 CAST(NULL AS STRING) AS dcw_supplier_nr,
 CAST(NULL AS STRING) AS branch_id,
 CAST(NULL AS STRING) AS branch_desc,
 CAST(NULL AS BIGNUMERIC) AS region_id,
 CAST(NULL AS STRING) AS region_desc,
 CAST(NULL AS STRING) AS global_location_nr,
 CAST(NULL AS STRING) AS supplier_category_id,
 CAST(NULL AS STRING) AS supplier_customer_nr,
 CAST(NULL AS STRING) AS supplier_tax_cd,
 CAST(NULL AS BIGNUMERIC) AS supplier_short_nr,
 CAST(NULL AS STRING) AS supplier_name2,
 CAST(NULL AS STRING) AS supplier_name3,
 CAST(NULL AS STRING) AS supplier_text_1,
 CAST(NULL AS STRING) AS supplier_text_2,
 CAST(NULL AS STRING) AS supplier_text_3,
 CAST(NULL AS STRING) AS supplier_text_4,
 CAST(NULL AS STRING) AS supplier_text_5,
 CAST(NULL AS STRING) AS main_negot_cntry_cd,
 CAST(NULL AS STRING) AS agg_co_negot_cntry_cd,
 CAST(NULL AS STRING) AS supplier_id_int
FROM (SELECT DISTINCT client_id
  FROM ldl_p_lew_process_ac.v_agc_client_cluster_2) AS clus;