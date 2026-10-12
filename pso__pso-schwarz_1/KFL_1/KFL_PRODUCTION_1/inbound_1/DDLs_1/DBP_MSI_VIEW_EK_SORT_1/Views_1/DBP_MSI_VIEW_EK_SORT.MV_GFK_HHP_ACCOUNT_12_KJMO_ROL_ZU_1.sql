CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_GFK_HHP_ACCOUNT_12_KJMO_ROL_ZU_1
-- 18.05.2018 Erweiterung um WÃýhrungs-ID wrg_id / mmzy2302
-- 11.06.2018 InnerJoin mit Tabelle mandant_wrg_typ_zu_1 / mmzy2302
-- 24.07.2018 Referenzen auf Feld wrg_typ_id sowie InnerJoin mit Tabelle mandant_wrg_typ_zu_1 wurden wieder auskommentiert/ mmzy2302
-- 10.04.2019 Filterung auf GFK_WG_ID = 1 entfernt / cbru1709

(
mandant_id
, gfk_account_id
, gfk_wg_id
, bewart_id
, eigenmarke_frische_fg
, kjmo_bis
, wrg_id
, kjmo_von
, umsatz_tsd_eur
, anz_einkauf_tsd
, durchschnitt_einkauf
, anz_artikel_einkauf
, durchschnitt_preis_artikel
, anz_kaeufer_tsd
, einkauf_frequenz
)

AS
SELECT

v01.mandant_id
, gfk_account_id
, gfk_wg_id
, bewart_id
, eigenmarke_frische_kz AS eigenmarke_frische_fg
, kjmo_bis
, v01.wrg_id
, kjmo_von
, umsatz_tsd_eur
, anz_einkauf_tsd
, durchschnitt_einkauf
, anz_artikel_einkauf
, durchschnitt_preis_artikel
, anz_kaeufer_tsd
, einkauf_frequenz

FROM dbp_view.v_gfk_hhp_wg_account_12_kjmo_rol_zu_1 v01;