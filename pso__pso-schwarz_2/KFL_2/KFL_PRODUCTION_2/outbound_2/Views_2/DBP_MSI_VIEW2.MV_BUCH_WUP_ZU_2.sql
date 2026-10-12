CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_buch_wup_zu_2 (wup_id, nb_id, mandant_id, bgrp_id) AS SELECT V01.wup_id
 ,
 V01.nb_id,
 V01.mandant_id,
  CASE
  WHEN V01.nb_id = 0 AND V01.wup_id IN (5560, 5670, 5730, 5700, 5550, 5540, 5710, 5650, 5690, 5720, 5610, 5660, 5620,
     5590, 5580, 5600, 5680, 5530, 5640, 5570, 5630)
  THEN 'GO'
  WHEN V01.nb_id = 0 AND V01.wup_id IN (5130, 5510, 5220, 5350, 5470, 5080, 5280, 5410, 5290, 5480, 5450, 5210, 5250,
     5170, 5090, 5260, 5500, 5150, 5110, 5420, 5370, 5330, 5320, 5390, 5230, 5430, 5120, 5460, 5300, 5200, 5520, 5190,
     5180, 5270, 5380, 5140, 5340)
  THEN 'GW'
  WHEN V01.nb_id = 0 AND V01.vw_id = 1
  THEN 'O'
  WHEN V01.nb_id = 0 AND V01.vw_id = 2
  THEN 'W'
  WHEN V01.nb_id = 0 AND V01.vw_id = 3
  THEN 'N'
  WHEN V01.nb_id = 0 AND V01.wup_id IN (1260, 1180, 1210, 1240, 1020, 1140, 1170, 1280)
  THEN 'CO'
  WHEN V01.nb_id = 0 AND V01.wup_id IN (1010, 1070, 1030, 1090, 1000, 1050, 1040, 1100, 1060, 1080)
  THEN 'CW'
  WHEN CAST(V02.zu_id AS FLOAT64) = 2
  THEN 'ZW'
  WHEN CAST(V02.zu_id AS FLOAT64) = 1
  THEN 'ZO'
  WHEN CAST(V02.zu_id AS FLOAT64) = 3
  THEN 'ZN'
  WHEN V01.nb_id = 0 AND V01.wup_id IN (5920, 5950)
  THEN 'EH'
  ELSE 'N/A'
  END AS bgrp_id
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_msi_view2.mv_vz_zuordnung_2 AS V02 ON V01.wup_id = V02.wup_id
WHERE V01.mandant_id = 1
 AND V01.nb_id IN (0, - 111);