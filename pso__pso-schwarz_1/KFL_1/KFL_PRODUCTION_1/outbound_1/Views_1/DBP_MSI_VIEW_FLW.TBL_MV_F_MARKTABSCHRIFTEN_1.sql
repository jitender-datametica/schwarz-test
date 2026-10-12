CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_marktabschriften_1 AS SELECT V01.mandant_id,
 V07.flw_kunde_id AS in_kunde_id,
 COLLATE(LTRIM(COLLATE(V07.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V07.kunde_name,
 V01.dat_umbew AS dat,
 V05.flw_art_id AS in_art_id,
 V05.in_art_nr,
 1 AS abschriften_fg,
 0 AS aufschriften_fg,
 V01.menge_erf,
 V01.menge_bestand_bme,
 V01.wrg_id,
 V100.default_wrg,
 V01.diff_wert_bestand_netto,
 V01.preis_aend_grund_id,
 V01.umbew_beleg_id,
 V01.wert_bestand_brutto_alt,
 V01.diff_wert_bestand_brutto,
 V01.vk_brutto_alt
FROM kfl_production_dbp_view.v_art_umbewertung_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat_umbew BETWEEN V04.dat_von AND V04.dat_bis
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id = V05.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_mwst_per_1 AS V06 ON V04.mwst_id = V06.mwst_id AND V04.mandant_id = V06.mandant_id
  AND V01.dat_umbew BETWEEN V06.dat_von AND V06.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V07 ON V01.wup_id = V07.wup_id AND V01.mandant_id = V07.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id;