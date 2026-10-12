CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_MARKTABSCHRIFTEN_1 
   AS  SELECT
   v01.mandant_id, v07.flw_kunde_id AS in_kunde_id, COLLATE(LTRIM(COLLATE(v07.kunde_nr,''),'0'), 'en-ci') AS kunde_nr,
   v07.kunde_name, v01.dat_umbew AS dat, v05.flw_art_id AS in_art_id, v05.in_art_nr, 1 AS abschriften_fg, 0 AS aufschriften_fg
   , v01.menge_erf, v01.menge_bestand_bme , v01.wrg_id,v100.default_wrg
   ,v01.diff_wert_bestand_netto, v01.preis_aend_grund_id, V01.UMBEW_BELEG_ID
   , V01.WERT_BESTAND_BRUTTO_ALT, V01.DIFF_WERT_BESTAND_BRUTTO
   , V01.VK_BRUTTO_ALT
   FROM dbp_view.v_art_umbewertung_1 v01
   INNER JOIN dbp_view.v_art_1 v04
   ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat_umbew BETWEEN v04.dat_von AND v04.dat_bis
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_1 v05     -- MARA_1 + Retailartikel

   ON v05.art_id = v04.art_id
   AND v05.mandant_id = v04.mandant_id
   LEFT OUTER JOIN dbp_view.v_mwst_per_1 v06
   ON v04.mwst_id = v06.mwst_id
   AND v04.mandant_id = v06.mandant_id
   AND v01.dat_umbew BETWEEN v06.dat_von AND v06.dat_bis
   LEFT JOIN dbp_view.v_flw_kunde_1 v07
   ON v01.wup_id = v07.wup_id
   AND v01.mandant_id = v07.mandant_id

   JOIN dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id;