CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t050_accounts_1 (wawi_instanz_kzl, c050_accountnr,
c050_accountdesc, c050_germandesc, c050_matchitems, c050_costtype, c050_moddate, c050_moduser, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c050_accountnr,
 c050_accountdesc,
 c050_germandesc,
 c050_matchitems,
 c050_costtype,
 c050_moddate,
 c050_moduser,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t050_accounts_1;