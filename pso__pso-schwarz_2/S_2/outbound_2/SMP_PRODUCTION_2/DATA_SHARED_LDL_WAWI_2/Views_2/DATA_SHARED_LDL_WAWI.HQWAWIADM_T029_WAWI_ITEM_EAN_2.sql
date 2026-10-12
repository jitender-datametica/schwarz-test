CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t029_wawi_item_ean_2 (wawi_instanz_kzl, seqid, posno
, itemno, ean_2, eandesc, location_2, transferdate, transferflag, action_flag, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 seqid,
 posno,
 itemno,
 ean_2,
 eandesc,
 location_2,
 transferdate,
 transferflag,
 action_flag,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t029_wawi_item_ean_2;