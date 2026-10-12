CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_relevancychecksdetail_010_1 (itemid, itemno,
shortdesc_int, znegotiatingcountry, `LO COUNTRY_1`, receivingcountry, supplierno, casesize, zarticletype, zlegacymatkl,
itemno_ba, bitflag, zisvalidbitflag, zisin_use, zisfood, ziseahassk, ziseahasba, zisskhasba, ziseahasskhasba,
zisvalidconstruct, zhasvalidtimelinelu, zhasvalidmaxlu, listingoverviewid, zhasvalidcontractdate, zhasvalidadsflg,
ziscurrentcontract, ziscurrentcontractfromsk, zforcerelevant, zforcenotrelevant, zisrelevantbyassociation, zactive,
ineksdata, adsflg, item_datefrom, item_dateuntil, contractpricevalidityid, zrelevantmdm) AS SELECT stmara_eks_item.itemid
 ,
 stmara_eks_item.itemno,
 REPLACE(REPLACE(REPLACE(stmara_eks_item.shortdesc_int, ';', ''), 'ž', 'z'), 'Ž', 'Z') AS
 shortdesc_int,
 stmara_eks_item.znegotiatingcountry,
 steks_listingoverviewmax.location_1 AS `LO Country_1`,
 steks_listingoverviewmax.receivingcountry,
 supplier.intsupplierno AS supplierno,
 steks_listingoverviewmax.casesize,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zlegacymatkl,
 stmara_eks_item_1.itemno AS itemno_ba,
 stmara_eks_item.bitflag,
 stmara_eks_item.zisvalidbitflag,
 stmara_eks_item.zisin_use,
 stmara_eks_item.zisfood,
 stmara_eks_item.ziseahassk,
 stmara_eks_item.ziseahasba,
 stmara_eks_item.zisskhasba,
 stmara_eks_item.ziseahasskhasba,
 stmara_eks_item.zisvalidconstruct,
 stmara_eks_item.zhasvalidtimelinelu,
 stmara_eks_item.zhasvalidmaxlu,
 steks_listingoverviewmax.listingoverviewid,
 stmara_eks_item.zhasvalidcontractdate,
 stmara_eks_item.zhasvalidadsflg,
 stmara_eks_item.ziscurrentcontract,
 stmara_eks_item.ziscurrentcontractfromsk,
 stmara_eks_item.zforcerelevant,
 stmara_eks_item.zforcenotrelevant,
 stmara_eks_item.zisrelevantbyassociation,
 stmara_eks_item.zactive,
  CASE
  WHEN v_boa_item_migration.itemid IS NULL
  THEN 'FALSE'
  ELSE 'TRUE'
  END AS ineksdata,
 IFNULL(eavalidity.adsflg, skvalidity.adsflg) AS adsflg,
 IFNULL(eavalidity.datefrom, skvalidity.datefrom) AS item_datefrom,
 IFNULL(eavalidity.dateuntil, skvalidity.dateuntil) AS item_dateuntil,
 IFNULL(eavalidity.contractpricevalidityid, skvalidity.contractpricevalidityid) AS contractpricevalidityid,
 stmara_eks_item.zrelevantmdm
FROM (SELECT DISTINCT listingoverviewid,
   casesize,
   sk_itemid,
   receivingcountry,
   supplierno,
   contractpricevalidityid
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1) AS SKLink
 LEFT JOIN idq_production_eks.contractpricevalidity_1 AS skvalidity ON SKLink.contractpricevalidityid = skvalidity.contractpricevalidityid
  
 RIGHT JOIN (idq_production_eks.supplier_1 INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_1 ON supplier_1
   .supplierno = steks_listingoverviewmax.supplierno) ON SKLink.listingoverviewid = steks_listingoverviewmax.listingoverviewid
       AND SKLink.casesize = steks_listingoverviewmax.casesize AND SKLink.sk_itemid = steks_listingoverviewmax.itemid
   AND SKLink.receivingcountry = steks_listingoverviewmax.receivingcountry AND SKLink.supplierno =
   steks_listingoverviewmax.supplierno
 LEFT JOIN (idq_production_eks.contractpricevalidity_1 AS eavalidity RIGHT JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   AS ealink ON eavalidity.contractpricevalidityid = ealink.contractpricevalidityid) ON steks_listingoverviewmax.listingoverviewid
        = ealink.listingoverviewid AND steks_listingoverviewmax.casesize = ealink.casesize AND steks_listingoverviewmax_1
      .itemid = ealink.itemid AND steks_listingoverviewmax.receivingcountry = ealink.receivingcountry AND
    steks_listingoverviewmax.supplierno = ealink.supplierno AND ealink.sk_itemid IS NULL
 RIGHT JOIN idq_production_eks_calculation.stmara_eks_item_1 ON steks_listingoverviewmax.itemid = stmara_eks_item.itemid
 LEFT JOIN idq_production_eks.v_boa_item_migration_1 ON stmara_eks_item.itemid = v_boa_item_migration.itemid
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item_1 ON stmara_eks_item.zitem_ba =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.constructed IS NULL;