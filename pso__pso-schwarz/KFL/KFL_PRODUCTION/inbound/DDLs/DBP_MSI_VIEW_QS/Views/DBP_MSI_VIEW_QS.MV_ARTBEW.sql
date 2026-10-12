CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_ARTBEW
(
  aktion_id
, art_id
, bewart_id
, bezugsweg_id
, bq_findung_id
, dat
, diff_ek_gld_konz
, diff_logkostenzuschlag_konz
, diff_umsatz_mwst_betrag_konz
, diff_umsatz_netto_konz
, einkaufsorganisation_id
, ek_gld
, gp_id
, herst_id
, logkostenzuschlag
, mandant_id
, menge
, mwst_id
, nb_id
, posten_id
, promo_fg
, umsatz_mwst_betrag
, umsatz_netto
, wrg
, wup_id
, umsatz_brutto
, umsatz_brutto_konz
)
AS
SELECT
  v01.aktion_id
, v01.art_id
, v01.bewart_id
, v01.bezugsweg_id
, v01.bq_findung_id
, v01.dat
, v01.diff_ek_gld_konz
, v01.diff_logkostenzuschlag_konz
, v01.diff_umsatz_mwst_betrag_konz
, v01.diff_umsatz_netto_konz
, v01.einkaufsorganisation_id
, v01.ek_gld
, v01.gp_id
, v01.herst_id
, v01.logkostenzuschlag
, v01.mandant_id
, v01.menge
, v01.mwst_id
, v01.nb_id
, v01.posten_id
, v01.promo_fg
, v01.umsatz_mwst_betrag
, v01.umsatz_netto
, v01.wrg
, v01.wup_id
, v01.umsatz_netto + v01.umsatz_mwst_betrag AS umsatz_brutto
, v01.diff_umsatz_netto_konz + v01.diff_umsatz_mwst_betrag_konz AS umsatz_brutto_konz

FROM dbp_view.v_artbew v01;