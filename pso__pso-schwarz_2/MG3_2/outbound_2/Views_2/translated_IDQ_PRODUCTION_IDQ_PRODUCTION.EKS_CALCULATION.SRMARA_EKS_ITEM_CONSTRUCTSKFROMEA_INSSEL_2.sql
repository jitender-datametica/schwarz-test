CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_constructskfromea_inssel_2 (zactive, itemid, bitflag
, employeeid, itemgrouptypeid, itemno, shortdesc_int, shortdesc_nat, description_int, description_nat, in_use,
zlegacymandt, zlegacymatnr, zlegacymatkl, zmatkl, zbismt, zmeins, zzeinr, zisvalidbitflag, zisin_use, zisfood,
ziscurrentcontract, znegotiatingcountry, zarticletype, zitem_ba, zsource, constructed, targetsystem, targetclient,
zmtart, zattyp, ztragr, zbwscl, zvabme, zbegru, zmstae, zmstde, ztaklv, zinhme, zinhal, constructedfrom, cr_locationid,
zlegacysatnr, zvpreh, zskcasesize) AS SELECT stmara.zactive,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(stmara.itemid AS STRING))) || CAST(stmara.itemid AS STRING)
    ) AS itemid,
 4 AS bitflag,
 stmara.employeeid,
 stmara.itemgrouptypeid,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(stmara.itemno AS STRING))) || CAST(stmara.itemno AS STRING)
    ) AS itemno,
 stmara.shortdesc_int,
 stmara.shortdesc_nat,
 stmara.description_int,
 stmara.description_nat,
 stmara.in_use,
 stmara.zlegacymandt,
  srmara_eks_item_zskcasesizeforea.itemprefix || (REPEAT('0', 7 - LENGTH(CAST(stmara.itemno AS STRING))) || CAST(stmara.itemno AS STRING)
    ) AS zlegacymatnr,
 stmara.zlegacymatkl,
 stmara.zmatkl,
 stmara.itemno AS zbismt,
 stmara.zmeins,
 stmara.zzeinr,
 stmara.zisvalidbitflag,
 stmara.zisin_use,
 stmara.zisfood,
 stmara.ziscurrentcontract,
 stmara.znegotiatingcountry,
 'SK' AS zarticletype,
 IFNULL(stmara.zitem_ba, ROUND(CAST('9990000000' || CAST(stmara.itemid AS STRING) AS BIGNUMERIC), 0)) AS zitem_ba,
 stmara.zsource,
 1 AS constructed,
 stmara.targetsystem,
 stmara.targetclient,
 'ZSK' AS zmtart,
 '12' AS zattyp,
 stmara.ztragr,
 stmara.zbwscl,
 stmara.zvabme,
 stmara.zbegru,
 stmara.zmstae,
 stmara.zmstde,
 stmara.ztaklv,
 NULL AS zinhme,
 NULL AS zinhal,
 stmara.itemid AS constructedfrom,
 stmara.cr_locationid,
 IFNULL(stmara.zitem_ba, ROUND(CAST('9990000000' || CAST(stmara.itemno AS STRING) AS BIGNUMERIC), 0)) AS zlegacysatnr,
 NULL AS zvpreh,
 srmara_eks_item_zskcasesizeforea.zskcasesize
FROM idq_production_eks_calculation.stmara_eks_item_2 AS stmara
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_zskcasesizeforea_2 ON stmara.itemid =
  srmara_eks_item_zskcasesizeforea.itemid
WHERE stmara.bitflag = 0
 AND stmara.zactive = 1
 AND stmara.ziscurrentcontract = 1;