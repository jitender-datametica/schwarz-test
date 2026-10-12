CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_ARTBEW_WG_SUM
(
mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
)
AS
SELECT
v01.mandant_id
, v01.wup_id
, v01.wg_id
, v01.bewart_id
, v01.dat
, v01.nb_id
, v01.arthiertyp_id
, v01.umsatz_brutto
, v01.umsatz_netto
, v01.umsatz_wrg
, v01.umsatz_brutto_konz
, v01.umsatz_netto_konz
, v01.kjmo
, v01.menge
, v01.quelle
FROM dbp_view.v_artbew_wg_sum v01;