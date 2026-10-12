CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_ba_descriptionnotendingwithba_sel_2 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, ba_bezeichnung_int
, description, ba_bezeichnung_nat, ba_bezeichnung_nat_long, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT ST_BA.znegotiatingcountry
  AS negotiatingcountry,
 ST_BA.buyershortsign,
 ST_BA.buyerfirstname,
 ST_BA.buyerlastname,
 ST_BA.zlegacymatkl AS zmatkl,
 ST_BA.articlefamily,
 ST_BA.itemid,
 ST_BA.itemno,
 ST_BA.zarticletype AS articletype,
 ST_BA.shortdesc_int AS ba_bezeichnung_int,
 ST_BA.description_int AS description,
 IT.shortdesc_nat AS ba_bezeichnung_nat,
 IT.description_nat AS ba_bezeichnung_nat_long,
 ST_BA.zrelevantmdm,
 ST_BA.zsource,
 ST_BA.zactive
FROM idq_production_eks_calculation.stmara_eks_item_2 AS ST_BA
 INNER JOIN idq_production_eks.item_2 AS IT ON ST_BA.itemid = IT.itemid AND ST_BA.zarticletype = 'BA' AND ST_BA.constructedfrom
  IS NULL
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ST_EA ON ST_BA.zitem_ba = ST_EA.zitem_ba AND ST_EA.zarticletype
     = 'EA' AND (ST_EA.zactive = 1 OR ST_EA.ziscurrentcontract = 1 OR ST_EA.ziscurrentcontractfromsk = 1)
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ST_SK ON ST_BA.zitem_ba = ST_SK.zitem_ba AND ST_SK.zarticletype
      = 'SK' AND ST_SK.constructedfrom IS NULL AND (ST_SK.zactive = 1 OR ST_SK.ziscurrentcontract = 1)
 LEFT JOIN idq_production_eks.itembuyerel_2 AS ITB ON ST_EA.itemid = ITB.itemid AND CURRENT_DATE BETWEEN CAST(ITB.datefrom AS DATE)
   AND (CAST(ITB.dateuntil AS DATE))
 LEFT JOIN idq_production_eks.employee_2 ON ST_EA.buyerid = employee.employeeid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_2 ON ST_BA.itemno = eks_zsm_excludelist.itemno AND
   eks_zsm_excludelist.reportno = '044'
WHERE (ST_BA.znegotiatingcountry <> 'GR' AND (COLLATE(RIGHT(RTRIM(ST_BA.shortdesc_int), 2), 'latin1_general_cs_as') <>
         'BA' OR COLLATE(RIGHT(RTRIM(ST_BA.description_int), 2), 'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(IT
           .shortdesc_nat), 2), 'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(IT.description_nat), 2),
        'latin1_general_cs_as') <> 'BA') OR ST_BA.znegotiatingcountry = 'GR' AND (COLLATE(RIGHT(RTRIM(ST_BA.shortdesc_int
              ), 2), 'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(ST_BA.shortdesc_int), 2
             ), 'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(ST_BA.shortdesc_int), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(ST_BA.description_int), 2),
            'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(ST_BA.description_int), 2),
            'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(ST_BA.description_int), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(IT.shortdesc_nat), 2),
           'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(IT.shortdesc_nat), 2),
           'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(IT.shortdesc_nat), 2),
          'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(IT.description_nat), 2),
          'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(IT.description_nat), 2),
          'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(IT.description_nat), 2),
         'sql_latin1_general_CP1253_cs_as') <> 'BΑ'))
 AND eks_zsm_excludelist.itemno IS NULL;