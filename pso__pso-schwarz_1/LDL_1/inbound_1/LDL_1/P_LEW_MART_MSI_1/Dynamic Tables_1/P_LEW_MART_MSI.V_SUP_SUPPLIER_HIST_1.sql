
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SUP_SUPPLIER_HIST_1
            
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI
            
            AS  
  
                /* # DescStart# , 
               #Subject Areas#: Lieferanten 
               #DescEnd# */ 
  
  
               SELECT 
                 supplierh.client_id, 
               supplierh.sup_sid AS supplier_id,  
               name1 AS supplier_name,  
               sort1 AS supplier_search_name, 
               dwh_valid_from AS dat_rec_start, 
               dwh_valid_to AS dat_rec_end, 
               wawi.dat_valid_from, 
               wawi.suppliergroup_id, 
               wawi.delivery_item_cd, 
               wawi.vat_id, 
               wawi.order_area_cd,  
               wawi.currency_iso_cd,  
               wawi.invoice_entry_fg, 
               wawi.intercompany_cd,  
               wawi.licence_cd, 
               wawi.title_cd, 
               supplierh.vat_ident_no AS vat_ident_nr,  
               wawi.broken_item_limit,  
               wawi.finance_office, 
               wawi.turnover_cd,  
               wawi.dcw_supplier_nr,  
               wawi.branch_id,  
               wawi.branch_desc,  
               wawi.region_id,  
               wawi.region_desc,  
               supplierh.global_location_nr,  
               wawi.supplier_category_id, 
               wawi.supplier_customer_nr, 
               supplierh.tax_no_1 AS supplier_tax_cd, 
               wawi.supplier_short_nr,  
               supplierh.name2 AS supplier_name2, 
               supplierh.name3 AS supplier_name3, 
               wawi.supplier_text_1,  
               wawi.supplier_text_2,  
               wawi.supplier_text_3,  
               wawi.supplier_text_4,  
               wawi.supplier_text_5,  
               supplierh.main_negot_cntry_cd, 
               supplierh.country_cd_conegot AS agg_co_negot_cntry_cd  
  
     FROM p_lew_bil_ac.v_supplier_1 AS supplierh  
               LEFT OUTER JOIN p_lew_core_ac.v_wawi_sup_supplier_1 AS wawi -- für alle Spalten, welche nur aus der WAWI genommen werden 
  
               ON supplierh.client_id=wawi.client_id  
               AND supplierh.sup_sid = wawi.sup_sid 
               AND supplierh.dwh_valid_from <= wawi.dat_rec_end 
               AND supplierh.dwh_valid_to >= wawi.dat_rec_start;
