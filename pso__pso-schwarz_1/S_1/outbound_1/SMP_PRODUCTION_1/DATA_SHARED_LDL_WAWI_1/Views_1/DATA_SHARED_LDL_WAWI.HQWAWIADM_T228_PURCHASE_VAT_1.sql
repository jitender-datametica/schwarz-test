CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t228_purchase_vat_1 (wawi_instanz_kzl, c228_krednr,
c228_purchase_vat, c228_mod_date, c228_mod_user, based_on_eks, c228_supp_category, scn, delete_fg, extraction_tmsp) AS
SELECT wawi_instanz_kzl,
 c228_krednr,
 c228_purchase_vat,
 c228_mod_date,
 c228_mod_user,
 based_on_eks,
 c228_supp_category,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t228_purchase_vat_1;