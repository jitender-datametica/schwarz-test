/* # DescStart# ,
#Subject Areas#: Lieferanten, Adresse, verhandelndes Land_2
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_supplier_2 AS
/* MSC-WARNING - MSCEWI1033 - FORMAT '9(13)' REMOVED, SEMANTIC INFORMATION NOT FOUND. ** */ SELECT SUPPLIERH.client_id,
 SUPPLIER.sup_sid,
 SUPPLIER.src_lifnr,
 SUPPLIER.src_orig_supplier_nr,
 ADDRESS.name1,
 ADDRESS.name2,
 ADDRESS.name3,
 ADDRESS.sort1,
 SUPPLIER.vat_ident_no,
 CAST(SUPPLIERH.int_location_no_1 * POWER(10, 6) + SUPPLIERH.int_location_no_2 * POWER(10, 1) + SUPPLIERH.int_location_checking_no AS STRING)
 AS global_location_nr,
 SUPPLIER.tax_no_1,
 COALESCE(SUPPLIERH.country_cd_negot, 'N/A') AS main_negot_cntry_cd,
 CAST(CASE
   WHEN CONEGH.deleted_fg = 0 AND CONEGH.country_cd_conegot_list IS NOT NULL
   THEN CONEGH.country_cd_conegot_list
   ELSE NULL
   END AS STRING) AS country_cd_conegot,
  CASE
  WHEN /* eks.deleted_fg = 0 AND */ EKS.eks_no_list IS NOT NULL
  THEN TRIM(EKS.eks_no_list)
  ELSE '0'
  END AS supplier_id_int,
  CASE
  WHEN CURRENT_DATE BETWEEN CASE
    WHEN (EKS.dwh_valid_from IS NULL OR EKS.dwh_valid_from <= SUPPLIERH.dwh_valid_from) AND (CONEGH.dwh_valid_from
       IS NULL OR CONEGH.dwh_valid_from <= SUPPLIERH.dwh_valid_from)
    THEN SUPPLIERH.dwh_valid_from
    WHEN EKS.dwh_valid_from IS NULL OR EKS.dwh_valid_from <= CONEGH.dwh_valid_from
    THEN CONEGH.dwh_valid_from
    ELSE EKS.dwh_valid_from
    END AND CASE
    WHEN (EKS.dwh_valid_to IS NULL OR EKS.dwh_valid_to >= SUPPLIERH.dwh_valid_to) AND (CONEGH.dwh_valid_to IS NULL OR
        CONEGH.dwh_valid_to >= SUPPLIERH.dwh_valid_to)
    THEN SUPPLIERH.dwh_valid_to
    WHEN EKS.dwh_valid_to IS NULL OR EKS.dwh_valid_to >= CONEGH.dwh_valid_to
    THEN CONEGH.dwh_valid_to
    ELSE EKS.dwh_valid_to
    END
  THEN 1
  ELSE 0
  END AS actual_fg_supplier,
  CASE
  WHEN CURRENT_DATE BETWEEN EKS.dwh_valid_from AND EKS.dwh_valid_to
  THEN 1
  ELSE 0
  END AS actual_fg_supplier_int,
  CASE
  WHEN CURRENT_DATE BETWEEN CONEGH.dwh_valid_from AND CONEGH.dwh_valid_to
  THEN 1
  ELSE 0
  END AS actual_fg_coneg_country,
  CASE
  WHEN EKS.deleted_fg = 0
  THEN 1
  ELSE 0
  END AS active_fg_eks,
  CASE
  WHEN CONEGH.deleted_fg = 0
  THEN 1
  ELSE 0
  END AS active_fg_conegh,
  CASE
  WHEN (EKS.dwh_valid_from IS NULL OR EKS.dwh_valid_from <= SUPPLIERH.dwh_valid_from) AND (CONEGH.dwh_valid_from IS NULL
     OR CONEGH.dwh_valid_from <= SUPPLIERH.dwh_valid_from)
  THEN SUPPLIERH.dwh_valid_from
  WHEN EKS.dwh_valid_from IS NULL OR EKS.dwh_valid_from <= CONEGH.dwh_valid_from
  THEN CONEGH.dwh_valid_from
  ELSE EKS.dwh_valid_from
  END AS dwh_valid_from,
  CASE
  WHEN (EKS.dwh_valid_to IS NULL OR EKS.dwh_valid_to >= SUPPLIERH.dwh_valid_to) AND (CONEGH.dwh_valid_to IS NULL OR
      CONEGH.dwh_valid_to >= SUPPLIERH.dwh_valid_to)
  THEN SUPPLIERH.dwh_valid_to
  WHEN EKS.dwh_valid_to IS NULL OR EKS.dwh_valid_to >= CONEGH.dwh_valid_to
  THEN CONEGH.dwh_valid_to
  ELSE EKS.dwh_valid_to
  END AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_supplier_2 AS SUPPLIER_2
 INNER JOIN ldl_p_lew_core_ac.v_supplier_hist_2 AS SUPPLIERH ON SUPPLIER.client_id = SUPPLIERH.client_id AND SUPPLIER.sup_sid
    = SUPPLIERH.sup_sid
 LEFT JOIN ldl_p_lew_core_ac.v_address_2 AS ADDRESS_2 ON SUPPLIERH.client_id = ADDRESS.client_id AND SUPPLIERH.addr_sid =
   ADDRESS.addr_sid
 LEFT JOIN ldl_p_lew_bil.t_supplier_coneg_country_hist_2 AS CONEGH ON SUPPLIERH.client_id = CONEGH.client_id AND SUPPLIER_2
     .sup_sid = CONEGH.sup_sid AND SUPPLIERH.dwh_valid_from <= CONEGH.dwh_valid_to AND SUPPLIERH.dwh_valid_to >= CONEGH
   .dwh_valid_from
 LEFT JOIN ldl_p_lew_bil.t_supplier_eks_hist_2 AS EKS ON SUPPLIERH.client_id = EKS.client_id AND SUPPLIERH.sup_sid = EKS.sup_sid
      AND SUPPLIERH.dwh_valid_from <= EKS.dwh_valid_to AND SUPPLIERH.dwh_valid_to >= EKS.dwh_valid_from
WHERE SUPPLIERH.loc_sid IS NULL;