CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_rech_det_kont_2 (system_id, mandant_id, rech_beleg_id,
rech_beleg_kont_pos_id, gj, kontierungsblock_nr, row_grund_id, dat_row, menge, basismenge_einh_id, sap_mwst_id, art_id,
betrag_beleg, dat_bezug, wg_id, arthiertyp_id, buch_grund_int_id, buch_grund_ext_id, menge_gp_best, betrag_gp_best,
gp_fehlerart_id, korrekturart_id, betrag_gp_fehler_netto, rech_kontoart_id, sperrgrund_betrag_fg, wup_id, nb_id,
betrag_netto, retourenpos_fg, dat_rpw, dat_buch, dat_beleg, dat_erfasst, dat_rech_eingang, pos_manuell_erstellt_fg) AS
SELECT 7 AS system_id,
 BRD.mandant_id,
 BRD.rech_beleg_id,
 BRD.rech_beleg_kont_pos_id,
 BRD.gj,
 BRD.kontierungsblock_nr,
 COALESCE(BRD.row_grund_id, '0') AS row_grund_id,
 BRD.dat_row,
 BRD.menge,
 BRD.basismenge_einh_id,
 BRD.sap_mwst_id,
 BRD.art_id,
 BRD.betrag_beleg,
 BRD.dat_bezug,
  CASE
  WHEN BRD.wg_id IS NULL
  THEN CAST(- 3 AS BIGNUMERIC)
  ELSE BRD.wg_id
  END AS wg_id,
 BRD.arthiertyp_id,
 COALESCE(BRD.buch_grund_int_id, '0') AS buch_grund_int_id,
 COALESCE(BRD.buch_grund_ext_id, '0') AS buch_grund_ext_id,
 BRD.menge_gp_best,
 BRD.betrag_gp_best,
 COALESCE(BRD.gp_fehlerart_id, '0') AS gp_fehlerart_id,
 COALESCE(BRD.korrekturart_id, '0') AS korrekturart_id,
 BRD.betrag_gp_fehler_netto,
 COALESCE(BRD.rech_kontoart_id, '0') AS rech_kontoart_id,
 BRD.sperrgrund_betrag_fg,
 BR.wup_id,
 BR.nb_id,
 BRD.betrag_netto,
 BRD.retourenpos_fg,
  CASE
  WHEN BR.rech_beleg_status_id = '5'
  THEN DATE(BR.dat_erfasst)
  ELSE NULL
  END AS dat_rpw_,
 BR.dat_buch,
 BR.dat_beleg,
 BR.dat_vorerfasst AS dat_erfasst,
 BR.dat_rech_eingang,
 1 AS pos_manuell_erstellt_fg
FROM kfl_production_dbp_view.v_besch_rech_det_kont_2 AS BRD
 INNER JOIN kfl_production_dbp_view.v_besch_rech_2 AS BR ON BRD.mandant_id = BR.mandant_id AND BRD.rech_beleg_id = BR.rech_beleg_id
     AND BRD.gj = BR.gj
WHERE BRD.mandant_id = 1;