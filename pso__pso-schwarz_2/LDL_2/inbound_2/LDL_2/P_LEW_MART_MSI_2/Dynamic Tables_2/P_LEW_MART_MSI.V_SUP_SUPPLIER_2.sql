
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.10.2017    -                        corrected join condition for v_wawi_sup_supplier_2
#  1.2  26.10.2017    -                        corrected where clause
#  1.3  15.11.2017    Wieber.Harald            Release 1.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  2.0  21.01.2021    Michal Malinowski        Added -1 dummy_2 record for supplier_id for each client_id
#                                              PatchNo: 2705, REP3-7970
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SUP_SUPPLIER_2 
COMMENT = '$Revision: 16774 $ '

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS   
   
SELECT
   supplierh.client_id
  ,supplierh.sup_sid            AS supplier_id
  ,CASE
     WHEN SUBSTR(supplierh.src_lifnr,1,1) > '9' THEN COALESCE(LTRIM(supplierh.src_orig_supplier_nr),supplierh.src_lifnr)
     ELSE COALESCE(LTRIM(supplierh.src_orig_supplier_nr),CAST(CAST(supplierh.src_lifnr AS INTEGER) AS VARCHAR(10)))
   END AS orig_supplier_nr
  ,supplierh.name1              AS supplier_name
  ,supplierh.sort1              AS supplier_search_name
  ,supplierh.dwh_valid_from     AS dat_rec_start    
  ,supplierh.dwh_valid_to       AS dat_rec_end
  ,wawi.dat_valid_from
  ,wawi.suppliergroup_id
  ,wawi.delivery_item_cd
  ,wawi.vat_id
  ,wawi.order_area_cd
  ,wawi.currency_iso_cd
  ,wawi.invoice_entry_fg
  ,wawi.intercompany_cd
  ,wawi.licence_cd
  ,wawi.title_cd
  ,supplierh.vat_ident_no       AS vat_ident_nr
  ,wawi.broken_item_limit
  ,wawi.finance_office
  ,wawi.turnover_cd
  ,wawi.dcw_supplier_nr
  ,wawi.branch_id
  ,wawi.branch_desc
  ,wawi.region_id
  ,wawi.region_desc
  ,supplierh.global_location_nr
  ,wawi.supplier_category_id
  ,wawi.supplier_customer_nr
  ,supplierh.tax_no_1           AS supplier_tax_cd
  ,wawi.supplier_short_nr
  ,supplierh.name2              AS supplier_name2
  ,supplierh.name3              AS supplier_name3
  ,wawi.supplier_text_1
  ,wawi.supplier_text_2
  ,wawi.supplier_text_3
  ,wawi.supplier_text_4
  ,wawi.supplier_text_5
  ,supplierh.main_negot_cntry_cd
  ,supplierh.country_cd_conegot AS agg_co_negot_cntry_cd
  ,supplierh.supplier_id_int
FROM P_LEW_BIL_AC.v_supplier_2                      AS supplierh
LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_sup_supplier_2 AS wawi  /* für alle Spalten, welche nur aus der WAWI genommen werden */
 ON supplierh.client_id = wawi.client_id
AND supplierh.sup_sid   = wawi.sup_sid
AND CURRENT_DATE BETWEEN wawi.dat_rec_start AND wawi.dat_rec_end /* Eingrenzen auf gueltige wawi Datensaetze */
WHERE supplierh.actual_fg_supplier = 1 /* Eingrenzen auf gueltige Supplier_2 */
UNION ALL
SELECT 
   client_id
  , -1 AS supplier_id
  ,CAST( NULL AS VARCHAR(10) ) AS orig_supplier_nr
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_name
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_search_name
  ,CAST( NULL AS DATE )        AS dat_rec_start    
  ,CAST( NULL AS DATE )        AS dat_rec_end
  ,CAST( NULL AS DATE )        AS dat_valid_from
  ,CAST( NULL AS INTEGER )     AS suppliergroup_id
  ,CAST( NULL AS VARCHAR(5) )  AS delivery_item_cd
  ,CAST( NULL AS INTEGER )     AS vat_id
  ,CAST( NULL AS VARCHAR(5) )  AS order_area_cd
  ,CAST( NULL AS VARCHAR(5) )  AS currency_iso_cd
  ,CAST( NULL AS INTEGER )     AS invoice_entry_fg
  ,CAST( NULL AS INTEGER )     AS intercompany_cd
  ,CAST( NULL AS VARCHAR(5) )  AS licence_cd
  ,CAST( NULL AS INTEGER )     AS title_cd
  ,CAST( NULL AS VARCHAR(5) )  AS vat_ident_nr
  ,CAST( NULL AS INTEGER )     AS broken_item_limit
  ,CAST( NULL AS VARCHAR(5) )  AS finance_office
  ,CAST( NULL AS INTEGER )     AS turnover_cd
  ,CAST( NULL AS VARCHAR(5) )  AS dcw_supplier_nr
  ,CAST( NULL AS VARCHAR(5) )  AS branch_id
  ,CAST( NULL AS VARCHAR(5) )  AS branch_desc
  ,CAST( NULL AS INTEGER )     AS region_id
  ,CAST( NULL AS VARCHAR(5) )  AS region_desc
  ,CAST( NULL AS VARCHAR(5) )  AS global_location_nr
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_category_id
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_customer_nr
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_tax_cd
  ,CAST( NULL AS INTEGER )     AS supplier_short_nr
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_name2
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_name3
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_text_1
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_text_2
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_text_3
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_text_4
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_text_5
  ,CAST( NULL AS VARCHAR(5) )  AS main_negot_cntry_cd
  ,CAST( NULL AS VARCHAR(5) )  AS agg_co_negot_cntry_cd
  ,CAST( NULL AS VARCHAR(5) )  AS supplier_id_int
FROM (
   SELECT DISTINCT client_id 
   FROM P_LEW_PROCESS_AC.v_agc_client_cluster_2 ) AS clus
;
