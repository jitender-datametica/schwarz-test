CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t117_itemstatus_2 (wawi_instanz_kzl, c117_itemno,
c117_warehouseno, c117_status, c117_updatedby, c117_updatedon, c117_reason, c117_first_sale_date, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c117_itemno,
 c117_warehouseno,
 c117_status,
 c117_updatedby,
 c117_updatedon,
 c117_reason,
 c117_first_sale_date,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t117_itemstatus_2;