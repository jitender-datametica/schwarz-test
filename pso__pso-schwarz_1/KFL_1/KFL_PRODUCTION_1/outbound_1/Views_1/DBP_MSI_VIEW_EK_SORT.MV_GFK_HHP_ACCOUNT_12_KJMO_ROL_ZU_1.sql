CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_account_12_kjmo_rol_zu_1 (mandant_id, gfk_account_id
, gfk_wg_id, bewart_id, eigenmarke_frische_fg, kjmo_bis, wrg_id, kjmo_von, umsatz_tsd_eur, anz_einkauf_tsd,
durchschnitt_einkauf, anz_artikel_einkauf, durchschnitt_preis_artikel, anz_kaeufer_tsd, einkauf_frequenz) AS SELECT
 mandant_id,
 gfk_account_id,
 gfk_wg_id,
 bewart_id,
 eigenmarke_frische_kz AS eigenmarke_frische_fg,
 kjmo_bis,
 wrg_id,
 kjmo_von,
 umsatz_tsd_eur,
 anz_einkauf_tsd,
 durchschnitt_einkauf,
 anz_artikel_einkauf,
 durchschnitt_preis_artikel,
 anz_kaeufer_tsd,
 einkauf_frequenz
FROM kfl_production_dbp_view.v_gfk_hhp_wg_account_12_kjmo_rol_zu_1 AS V01;