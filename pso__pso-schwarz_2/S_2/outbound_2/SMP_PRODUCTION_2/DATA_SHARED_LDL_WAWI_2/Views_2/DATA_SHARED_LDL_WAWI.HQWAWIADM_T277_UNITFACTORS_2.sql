CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t277_unitfactors_2 (wawi_instanz_kzl, c277_id,
c277_unit, c277_baseunit, c277_basefactor, c277_intunit, c277_intfactor, c277_validfrom, c277_validuntil, c277_eks_link
, c277_base_family, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c277_id,
 c277_unit,
 c277_baseunit,
 c277_basefactor,
 c277_intunit,
 c277_intfactor,
 c277_validfrom,
 c277_validuntil,
 c277_eks_link,
 c277_base_family,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t277_unitfactors_2;