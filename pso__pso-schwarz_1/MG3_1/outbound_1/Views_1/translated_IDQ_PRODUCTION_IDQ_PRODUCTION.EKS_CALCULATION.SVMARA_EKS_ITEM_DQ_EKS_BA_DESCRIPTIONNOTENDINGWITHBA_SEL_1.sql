CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_ba_descriptionnotendingwithba_sel_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, ba_bezeichnung_int
, description, ba_bezeichnung_nat, ba_bezeichnung_nat_long, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT st_ba.znegotiatingcountry
  AS negotiatingcountry,
 st_ba.buyershortsign,
 st_ba.buyerfirstname,
 st_ba.buyerlastname,
 st_ba.zlegacymatkl AS zmatkl,
 st_ba.articlefamily,
 st_ba.itemid,
 st_ba.itemno,
 st_ba.zarticletype AS articletype,
 st_ba.shortdesc_int AS ba_bezeichnung_int,
 st_ba.description_int AS description,
 it.shortdesc_nat AS ba_bezeichnung_nat,
 it.description_nat AS ba_bezeichnung_nat_long,
 st_ba.zrelevantmdm,
 st_ba.zsource,
 st_ba.zactive
FROM idq_production_eks_calculation.stmara_eks_item_1 AS st_ba
 INNER JOIN idq_production_eks.item_1 AS it ON st_ba.itemid = it.itemid AND st_ba.zarticletype = 'BA' AND st_ba.constructedfrom
  IS NULL
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS st_ea ON st_ba.zitem_ba = st_ea.zitem_ba AND st_ea.zarticletype
     = 'EA' AND (st_ea.zactive = 1 OR st_ea.ziscurrentcontract = 1 OR st_ea.ziscurrentcontractfromsk = 1)
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_1 AS st_sk ON st_ba.zitem_ba = st_sk.zitem_ba AND st_sk.zarticletype
      = 'SK' AND st_sk.constructedfrom IS NULL AND (st_sk.zactive = 1 OR st_sk.ziscurrentcontract = 1)
 LEFT JOIN idq_production_eks.itembuyerel_1 AS itb ON st_ea.itemid = itb.itemid AND CURRENT_DATE BETWEEN CAST(itb.datefrom AS DATE)
   AND (CAST(itb.dateuntil AS DATE))
 LEFT JOIN idq_production_eks.employee_1 ON st_ea.buyerid = employee.employeeid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_1 ON st_ba.itemno = eks_zsm_excludelist.itemno AND
   eks_zsm_excludelist.reportno = '044'
WHERE (st_ba.znegotiatingcountry <> 'GR' AND (COLLATE(RIGHT(RTRIM(st_ba.shortdesc_int), 2), 'latin1_general_cs_as') <>
         'BA' OR COLLATE(RIGHT(RTRIM(st_ba.description_int), 2), 'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(it
           .shortdesc_nat), 2), 'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(it.description_nat), 2),
        'latin1_general_cs_as') <> 'BA') OR st_ba.znegotiatingcountry = 'GR' AND (COLLATE(RIGHT(RTRIM(st_ba.shortdesc_int
              ), 2), 'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(st_ba.shortdesc_int), 2
             ), 'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(st_ba.shortdesc_int), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(st_ba.description_int), 2),
            'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(st_ba.description_int), 2),
            'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(st_ba.description_int), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(it.shortdesc_nat), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(it.shortdesc_nat), 2),
           'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(it.shortdesc_nat), 2),
          'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(it.description_nat), 2),
          'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(it.description_nat), 2),
          'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(it.description_nat), 2),
         'sql_latin1_general_CP1253_cs_as') <> 'BΑ'))
 AND eks_zsm_excludelist.itemno IS NULL;