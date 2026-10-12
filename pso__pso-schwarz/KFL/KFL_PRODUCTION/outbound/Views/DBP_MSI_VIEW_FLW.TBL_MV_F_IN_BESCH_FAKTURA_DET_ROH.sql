CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_faktura_det_roh (faktura_beleg_id,
faktura_beleg_pos_id, mandant_id, dat_faktura, werk_id, lief_pos_typ_id, in_art_id, vorlage_beleg_id, menge_faktura_vkme
, menge_faktura_lme, verk_menge_faktura_einh_id, gewicht_netto_roh, dat_preisfindung, default_wrg, vorzeichen_preise,
vorzeichen_mengen, wrg_id_v02, wert_ek_netto_v02) AS SELECT V02.faktura_beleg_id,
 V02.faktura_beleg_pos_id,
 V02.mandant_id,
 V01.dat_faktura,
 V02.werk_id,
 V02.lief_pos_typ_id,
 V02.flw_art_id AS in_art_id,
 V02.vorlage_beleg_id,
 MAX(CASE
    WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
      'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
    THEN - 1
    ELSE 1
    END * V02.menge_faktura_vkme) AS menge_faktura_vkme,
 MAX(CASE
    WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
      'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
    THEN - 1
    ELSE 1
    END * V02.menge_faktura_lme) AS menge_faktura_lme,
 V02.verk_menge_einh_id AS verk_menge_faktura_einh_id,
 MAX(CASE
    WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
      'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
    THEN - 1
    ELSE 1
    END * V02.gewicht_netto) AS gewicht_netto_roh,
 MAX(V02.dat_preisfindung) AS dat_preisfindung,
 V100.default_wrg,
  CASE
  WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
    'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25')
  THEN - 1
  ELSE 1
  END AS vorzeichen_preise,
  CASE
  WHEN V01.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
    'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
  THEN - 1
  ELSE 1
  END AS vorzeichen_mengen,
 V02.wrg_id AS wrg_id_v02,
 V02.wert_ek_netto AS wert_ek_netto_v02
FROM kfl_production_dbp_view.v_flw_besch_faktura AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_faktura_det AS V02 ON V01.mandant_id = V02.mandant_id AND V01.faktura_beleg_id
    = V02.faktura_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_besch_partner AS V03 ON V01.mandant_id = V03.mandant_id AND V01.faktura_beleg_id
    = V03.faktura_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_art AS V04 ON V01.mandant_id = V04.mandant_id AND V02.flw_art_id = V04.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V02.mandant_id = V100.mandant_id
WHERE V03.partner_verwendung_id = 'WE'
 AND V04.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW', 'ZFLV'
   )
 AND V01.flw_vw_id IN (10, 20)
 AND V01.mandant_id IN (1, 2)
GROUP BY V02.faktura_beleg_id,
 V02.faktura_beleg_pos_id,
 V02.mandant_id,
 V01.dat_faktura,
 V02.werk_id,
 V02.lief_pos_typ_id,
 in_art_id,
 V02.vorlage_beleg_id,
 verk_menge_faktura_einh_id,
 V100.default_wrg,
 vorzeichen_preise,
 vorzeichen_mengen,
 wrg_id_v02,
 wert_ek_netto_v02;