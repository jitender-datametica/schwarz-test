CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_faktura_det_1 AS SELECT V02.faktura_beleg_id,
 V02.faktura_beleg_pos_id,
 V02.mandant_id,
 V02.system_id,
 V02.werk_id,
 V02.lief_pos_typ_id,
 V02.flw_art_id AS in_art_id,
 V02.vorlage_beleg_id,
  CASE
  WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
    'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFS3')
  THEN - 1
  ELSE 1
  END AS vorzeichen_preise,
  CASE
  WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
    'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6', 'ZFS3')
  THEN - 1
  ELSE 1
  END AS vorzeichen_mengen,
   CASE
   WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
     'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6', 'ZFS3')
   THEN - 1
   ELSE 1
   END * V02.menge_faktura_vkme AS menge_faktura_vkme_tmp,
   CASE
   WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
     'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6', 'ZFS3')
   THEN - 1
   ELSE 1
   END * V02.menge_faktura_lme AS menge_faktura_lme_tmp,
 V02.verk_menge_einh_id AS verk_menge_faktura_einh_id,
     CASE
     WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
       'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6', 'ZFS3')
     THEN - 1
     ELSE 1
     END * V02.gewicht_netto * v16.zaehler / v16.nenner AS gewicht_netto,
 V02.dat_preisfindung,
 V02.dat_leist_erstellung,
 V100.default_wrg,
 V02.wrg_id,
 V02.wert_ek_netto,
 V02.zwsum_2_betrag,
 V02.vk_brutto,
 V02.menge_faktura_lme,
 V02.gewicht_netto AS gewicht_netto_v02,
 V11.mwst,
 V05.basismenge_einh_id,
 v16.zaehler,
 v16.nenner,
 V15.umrech_faktor
FROM kfl_production_dbp_view.v_flw_besch_faktura_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_faktura_det_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.faktura_beleg_id
    = V02.faktura_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V02.flw_art_id = V04.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id = V05.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_mwst_per_1 AS V11 ON V05.mandant_id = V11.mandant_id AND V05.mwst_id = V11.mwst_id
  AND V02.dat_preisfindung BETWEEN V11.dat_von AND V11.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_mwst_per_1 AS V14 ON V05.mandant_id = V14.mandant_id AND V05.mwst_id = V14.mwst_id
  AND V01.dat_faktura BETWEEN V14.dat_von AND V14.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V15 ON V04.mandant_id = V15.mandant_id AND V04.flw_art_id
     = V15.flw_art_id AND CASE
    WHEN V04.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V04.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V15.altnv_menge_einh_id
 LEFT JOIN (SELECT V016A.mandant_id,
   V016A.system_id,
   V016A.altnv_menge_einh_id,
   V016A.flw_art_id,
   V016A.gew_einh_id,
   V016B.zaehler,
   V016B.nenner
  FROM kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V016A
   INNER JOIN kfl_production_dbp_view.v_flw_einheiten_umrechnung_1 AS V016B ON V016A.gew_einh_id = V016B.einh_id) AS v16
 ON V02.mandant_id = v16.mandant_id AND V04.flw_art_id = v16.flw_art_id AND V04.basismenge_einh_id = v16.altnv_menge_einh_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V02.mandant_id = V100.mandant_id
WHERE V04.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND V01.mandant_id IN (1, 2);