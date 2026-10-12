CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t042_intprodgrp_1 (wawi_instanz_kzl, c042_prodgrpnr,
c042_descshort, c042_desc, c042_sortingterm, c042_moduser, c042_moddate, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c042_prodgrpnr,
 c042_descshort,
 c042_desc,
 c042_sortingterm,
 c042_moduser,
 c042_moddate,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t042_intprodgrp_1;