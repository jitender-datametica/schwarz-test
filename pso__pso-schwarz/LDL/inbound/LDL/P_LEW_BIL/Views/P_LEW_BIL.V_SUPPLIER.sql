CREATE OR REPLACE VIEW P_LEW_BIL.V_SUPPLIER
AS

/* # DescStart# ,
#Subject Areas#: Lieferanten, Adresse, verhandelndes Land
#DescEnd# */
SELECT
  client_id
, sup_sid
, src_lifnr
, src_orig_supplier_nr
, name1
, name2
, name3
, sort1
, vat_ident_no
, global_location_nr
, tax_no_1
, main_negot_cntry_cd
, country_cd_conegot
, supplier_id_int
, actual_fg_supplier
, actual_fg_supplier_int
, actual_fg_coneg_country
, active_fg_eks
, active_fg_conegh
, dwh_valid_from_x AS dwh_valid_from
, dwh_valid_to_x   AS dwh_valid_to
FROM
(SELECT
  supplierh.client_id
, supplier.sup_sid
, supplier.src_lifnr
, supplier.src_orig_supplier_nr
, address.name1
, address.sort1
, CASE
      WHEN ( eks.dwh_valid_from IS NULL OR eks.dwh_valid_from <= supplierh.dwh_valid_from )
           AND
           ( conegh.dwh_valid_from IS NULL OR conegh.dwh_valid_from <= supplierh.dwh_valid_from )
      THEN supplierh.dwh_valid_from
      WHEN eks.dwh_valid_from IS NULL OR eks.dwh_valid_from <= conegh.dwh_valid_from
      THEN conegh.dwh_valid_from
      ELSE eks.dwh_valid_from
    END                                                                                            AS dwh_valid_from_x
, CASE
      WHEN ( eks.dwh_valid_to IS NULL OR eks.dwh_valid_to >= supplierh.dwh_valid_to )
           AND
           ( conegh.dwh_valid_to IS NULL OR conegh.dwh_valid_to >= supplierh.dwh_valid_to )
      THEN supplierh.dwh_valid_to
      WHEN eks.dwh_valid_to IS NULL OR eks.dwh_valid_to >= conegh.dwh_valid_to
      THEN conegh.dwh_valid_to
      ELSE eks.dwh_valid_to
    END                                                                                            AS dwh_valid_to_x
, supplier.vat_ident_no
, Cast((supplierh.int_location_no_1 * Power(10, 6) + supplierh.int_location_no_2 * Power(10, 1) + supplierh.int_location_checking_no) /*** MSC-WARNING - MSCEWI1033 - FORMAT '9(13)' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR(13))
                                                                                                   AS global_location_nr
, supplier.tax_no_1
, address.name2
, address.name3
, Coalesce(supplierh.country_cd_negot, 'N/A')                                                    AS main_negot_cntry_cd
, Cast(CASE WHEN conegh.deleted_fg = 0 AND conegh.country_cd_conegot_list IS NOT NULL THEN conegh.country_cd_conegot_list ELSE NULL END AS VARCHAR(100)) AS country_cd_conegot
, CASE WHEN /*eks.deleted_fg = 0 AND*/ eks.eks_no_list IS NOT NULL THEN Trim(eks.eks_no_list) ELSE '0' END AS supplier_id_int
, CASE WHEN CURRENT_DATE BETWEEN dwh_valid_from_x AND dwh_valid_to_x THEN 1 ELSE 0 END           AS actual_fg_supplier
, CASE WHEN CURRENT_DATE BETWEEN eks.dwh_valid_from AND eks.dwh_valid_to  THEN 1 ELSE 0 END      AS actual_fg_supplier_int
, CASE WHEN CURRENT_DATE BETWEEN conegh.dwh_valid_from AND conegh.dwh_valid_to THEN 1 ELSE 0 END AS actual_fg_coneg_country
, CASE WHEN eks.deleted_fg = 0 THEN 1 ELSE 0 END                                                 AS active_fg_eks
, CASE WHEN conegh.deleted_fg = 0 THEN 1 ELSE 0 END                                              AS active_fg_conegh
FROM p_lew_core_ac.v_supplier                           AS supplier

INNER JOIN p_lew_core_ac.v_supplier_hist                AS supplierh
ON supplierh.client_id= supplier.client_id
AND supplierh.sup_sid = supplier.sup_sid

LEFT OUTER JOIN p_lew_core_ac.v_address                 AS address -- Alle Adressdaten; diese sind nicht historisiert
ON supplierh.client_id = address.client_id
AND supplierh.addr_sid = address.addr_sid
--AND (address.lang_cd = 'DE' OR address.lang_cd IS NULL)

LEFT OUTER JOIN p_lew_bil.t_supplier_coneg_country_hist AS conegh  -- Mitverhandelndes Land, dass zusätzliche Artikel bestellen möchte, die vom Hauptverhandelten Land nicht benötigt werden
ON supplierh.client_id =conegh.client_id
AND supplier.sup_sid = conegh.sup_sid
AND supplierh.dwh_valid_from <= conegh.dwh_valid_to
AND supplierh.dwh_valid_to >= conegh.dwh_valid_from

LEFT OUTER JOIN p_lew_bil.t_supplier_eks_hist           AS eks     -- Internationale Lieferantennumer aus dem Einkauf
ON supplierh.client_id = eks.client_id
AND supplierh.sup_sid = eks.sup_sid
AND supplierh.dwh_valid_from <= eks.dwh_valid_to
AND supplierh.dwh_valid_to >= eks.dwh_valid_from

WHERE supplierh.loc_sid IS NULL
) tabi
;
