CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_FAKTURAART_SPR_ZU (
   mandant_id,
   fakturaart_id,
   spr_id,
   fakturaart_bez,
   f_soll_haben
) AS 
--12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
--alt neu
--G2 ZGLT,ZGWP,ZEWP
--L2 ZVLT,ZMWP
--S1 ZSLT,ZSMP
--S2 Z5LT,Z5MP,ZSWP,ZGEP
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.fakturaart_id,
   v01.spr_id,
   fakturaart_bez,
   CASE
      WHEN v01.fakturaart_id IN (
         'ZIVS',
         'S1',
         'ZSLT',
         'ZSMP',
         'ZLG2',
         'G2',
         'ZGLT',
         'ZGWP',
         'ZEWP',
         'ZLRE',
         'ZLIG',
         'ZLLS',
         'ZLUS'
      ) THEN '-'
      ELSE '+'
   END AS f_soll_haben
FROM
   dbp_view.v_fakturaart_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   fakturaart_id IN (
      'G2',
      'ZGLT',
      'ZGWP',
      'ZEWP',
      'L2',
      'ZVLT',
      'ZMWP',
      'S1',
      'ZSLT',
      'ZSMP',
      'S2',
      'Z5LT',
      'Z5MP',
      'ZSWP',
      'ZGEP',
      'ZF1',
      'ZIV',
      'ZIVS',
      'ZLF2',
      'ZLG2',
      'ZLIG',
      'ZLL2',
      'ZLLS',
      'ZLRE',
      'ZLRS',
      'ZLS2',
      'ZLUL',
      'ZLUS'
   );