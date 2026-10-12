CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_ARTBEW_KONTO_TAG
(
konto_id
, arthiertyp_id
, mandant_id
, wup_id
, nb_id
, bewart_id
, dat
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
)
AS
SELECT
v01.konto_id
, v01.arthiertyp_id
, v01.mandant_id
, v01.wup_id
, v01.nb_id
, v01.bewart_id
, v01.dat
, v01.umsatz_brutto
, v01.umsatz_netto
, v01.umsatz_wrg
, v01.umsatz_brutto_konz
, v01.umsatz_netto_konz
FROM dbp_view.v_artbew_konto_tag v01;