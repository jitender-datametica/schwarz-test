CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_constructskfromea_inssel_2 (zactive, itemid, bitflag
, employeeid, itemgrouptypeid, itemno, shortdesc_int, shortdesc_nat, description_int, description_nat, in_use,
zlegacymandt, zlegacymatnr, zlegacymatkl, zmatkl, zbismt, zmeins, zzeinr, zisvalidbitflag, zisin_use, zisfood,
ziscurrentcontract, znegotiatingcountry, zarticletype, zitem_ba, zsource, constructed, targetsystem, targetclient,
zmtart, zattyp, ztragr, zbwscl, zvabme, zbegru, zmstae, zmstde, ztaklv, zinhme, zinhal, constructedfrom, cr_locationid,
zlegacysatnr, zvpreh, zskcasesize) AS SELECT STMARA.zactive,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(STMARA.itemid AS STRING))) || CAST(STMARA.itemid AS STRING)
    ) AS itemid,
 4 AS bitflag,
 STMARA.employeeid,
 STMARA.itemgrouptypeid,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(STMARA.itemno AS STRING))) || CAST(STMARA.itemno AS STRING)
    ) AS itemno,
 STMARA.shortdesc_int,
 STMARA.shortdesc_nat,
 STMARA.description_int,
 STMARA.description_nat,
 STMARA.in_use,
 STMARA.zlegacymandt,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(STMARA.itemno AS STRING))) || CAST(STMARA.itemno AS STRING)
    ) AS zlegacymatnr,
 STMARA.zlegacymatkl,
 STMARA.zmatkl,
 STMARA.itemno AS zbismt,
 STMARA.zmeins,
 STMARA.zzeinr,
 STMARA.zisvalidbitflag,
 STMARA.zisin_use,
 STMARA.zisfood,
 STMARA.ziscurrentcontract,
 STMARA.znegotiatingcountry,
 'SK' AS zarticletype,
 IFNULL(STMARA.zitem_ba, ROUND(CAST('9990000000' || CAST(STMARA.itemid AS STRING) AS BIGNUMERIC), 0)) AS zitem_ba,
 STMARA.zsource,
 1 AS constructed,
 STMARA.targetsystem,
 STMARA.targetclient,
 'ZSK' AS zmtart,
 '12' AS zattyp,
 STMARA.ztragr,
 STMARA.zbwscl,
 STMARA.zvabme,
 STMARA.zbegru,
 STMARA.zmstae,
 STMARA.zmstde,
 STMARA.ztaklv,
 NULL AS zinhme,
 NULL AS zinhal,
 STMARA.itemid AS constructedfrom,
 STMARA.cr_locationid,
 IFNULL(STMARA.zitem_ba, ROUND(CAST('9990000000' || CAST(STMARA.itemno AS STRING) AS BIGNUMERIC), 0)) AS zlegacysatnr,
 NULL AS zvpreh,
 srmara_eks_item_zskcasesizeforea.zskcasesize
FROM idq_production_eks_calculation.stmara_eks_item_2 AS STMARA
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_zskcasesizeforea_2 ON STMARA.itemid =
  srmara_eks_item_zskcasesizeforea.itemid
WHERE STMARA.bitflag = 0
 AND STMARA.zactive = 1
 AND STMARA.ziscurrentcontract = 1;