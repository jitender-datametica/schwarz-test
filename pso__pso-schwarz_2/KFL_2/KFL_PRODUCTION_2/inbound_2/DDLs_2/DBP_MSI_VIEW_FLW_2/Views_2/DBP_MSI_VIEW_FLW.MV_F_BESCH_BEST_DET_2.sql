CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_BESCH_BEST_DET_2
(
mandant_id
, best_beleg_id
, best_beleg_pos_id
, art_id
, wup_id
, nb_id
, lagerort_id
, loesch_fg
, menge_best_bme
, selbstabhol_fg
, best_preis_menge_einh_id
, menge_best_kolli
, menge_best_palette
, endlief_fg
, dat_aenderung
, kunde_id
, dat_best_beleg
, best_menge_einh_id
, ean_id
, betrag_kond_zw_sum2
, pos_kostenlos_fg
, betrag_pos_netto
, betrag_pos_netto_best_wrg
, wrg_id
, betrag_best
, menge_block_bestand
, gp_teilsortiment_id
, dat_lief_wunsch
, dat_naechst_verkaufstag
)
AS
   SELECT
   v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id, v01.art_id, v01.wup_id, v01.nb_id, v01.lagerort_id, v01.loesch_fg, v01.menge_best_bme, v01.selbstabhol_fg, v01.best_preis_menge_einh_id, v01.menge_best_kolli, v01.menge_best_palette, v01.endlief_fg, v01.dat_aenderung, v01.kunde_id, v01.dat_best_beleg, v01.best_menge_einh_id, v01.ean_id, v01.betrag_kond_zw_sum2, v01.pos_kostenlos_fg, v01.betrag_pos_netto, v01.betrag_pos_netto_best_wrg, v01.wrg_id, v01.betrag_best, v01.menge_block_bestand, v01.gp_teilsortiment_id, v02.dat_lief_wunsch, v03.dat_naechst_verkaufstag

   FROM dbp_view.v_besch_best_det_2 v01

   JOIN (
   SELECT
   v11.best_beleg_id, v11.mandant_id, v11.best_beleg_pos_id, v11.dat_lief_wunsch, v11.einteil_id, v11.flw_fg
   FROM dbp_view.v_lief_einteilung_2 v11
   WHERE v11.flw_fg = 1
   --Bei mehreren Einteilungen, das Datum aus der ersten nutzen
   AND v11.einteil_id = 1
   ) v02
   ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.best_beleg_pos_id  = v02.best_beleg_pos_id
   AND v01.flw_fg = v02.flw_fg
   LEFT OUTER JOIN dbp_view.v_art_wup_tag_denorm_2 v03
   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND v02.dat_lief_wunsch = v03.dat

   WHERE
   v01.mandant_id = 1
   AND v01.flw_fg = 1
   AND v01.loesch_fg = 0;