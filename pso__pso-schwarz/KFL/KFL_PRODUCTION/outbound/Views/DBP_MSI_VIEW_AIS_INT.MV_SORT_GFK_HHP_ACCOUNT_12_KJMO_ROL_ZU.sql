CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_gfk_hhp_account_12_kjmo_rol_zu (mandant_id,
gfk_account_id, gfk_wg_id, bewart_id, eigenmarke_frische_fg, kjmo_bis, wrg_id, kjmo_von, umsatz_tsd_eur, anz_einkauf_tsd
, durchschnitt_einkauf, anz_artikel_einkauf, durchschnitt_preis_artikel, anz_kaeufer_tsd, einkauf_frequenz) AS SELECT
 V01.mandant_id,
 V01.gfk_account_id,
 V01.gfk_wg_id,
 V01.bewart_id,
 V01.eigenmarke_frische_kz AS eigenmarke_frische_fg,
 V01.kjmo_bis,
 V01.wrg_id,
 V01.kjmo_von,
 V01.umsatz_tsd_eur,
 V01.anz_einkauf_tsd,
 V01.durchschnitt_einkauf,
 V01.anz_artikel_einkauf,
 V01.durchschnitt_preis_artikel,
 V01.anz_kaeufer_tsd,
 V01.einkauf_frequenz
FROM kfl_production_dbp_data.gfk_hhp_wg_account_12_kjmo_rol_zu AS V01
 INNER JOIN kfl_production_dbp_data.monat AS V02 ON V01.kjmo_bis = V02.kjmo
WHERE V02.akt_mo BETWEEN - 36 AND 0
 AND (V01.mandant_id IN (1, 5, 6, 8) AND V01.wrg_id = 'EUR' OR V01.mandant_id = 2 AND V01.wrg_id = 'CZK' OR V01.mandant_id
       = 3 AND V01.wrg_id = 'PLN' OR V01.mandant_id = 7 AND V01.wrg_id = 'RON');