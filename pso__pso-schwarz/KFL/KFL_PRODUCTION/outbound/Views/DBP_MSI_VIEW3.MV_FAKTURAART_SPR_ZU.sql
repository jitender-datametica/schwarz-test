-- G2 ZGLT,ZGWP,ZEWP
 -- alt neu
 -- 20230717 staeblern Umstellung auf Session Variable
 -- S2 Z5LT,Z5MP,ZSWP,ZGEP

-- L2 ZVLT,ZMWP
 -- 12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
 -- S1 ZSLT,ZSMP

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_fakturaart_spr_zu(USERID STRING) AS SELECT V01.mandant_id,
 V01.fakturaart_id,
 V01.spr_id,
 V01.fakturaart_bez,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN '-'
  ELSE '+'
  END AS f_soll_haben
FROM kfl_production_dbp_view.v_fakturaart_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.fakturaart_id IN ('G2', 'ZGLT', 'ZGWP', 'ZEWP', 'L2', 'ZVLT', 'ZMWP', 'S1', 'ZSLT', 'ZSMP', 'S2', 'Z5LT',
   'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZIVS', 'ZLF2', 'ZLG2', 'ZLIG', 'ZLL2', 'ZLLS', 'ZLRE', 'ZLRS', 'ZLS2', 'ZLUL'
   , 'ZLUS');