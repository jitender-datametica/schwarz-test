CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_basis_gebinde_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
art_id_basis OPTIONS(description='Basisartikel'), art_id_gebinde OPTIONS(description='Gebindeartikel'), umrech_zaehler
OPTIONS(description='Zähler für die Umrechnung'), umrech_nenner OPTIONS(description='Nenner für die Umrechnung'),
umrech_faktor OPTIONS(description='Faktor für die Umrechnung'), anz_einzel_art
OPTIONS(description='Anzahl der Einzelartikel im Gebinde. - Quelle: ZEKFLAKI.ME_ASF'), anz_basis_art
OPTIONS(description='Anzahl des Basisartikel im Gebinde. Ein Basisartikel kann aus einem oder mehreren Einzelartikeln bestehen. - Quelle: ZEKFLAKI.Y'),
dispo_fg OPTIONS(description='Dispokennzeichen'), status_kz
OPTIONS(description='Kennzeichen für den Status_2 des Eintrags im Quellsystem: L = gelöscht, N = neu, A = Änderung. - Quelle: ZEKFLAKI.VWKZ'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE BASISARTIKEL ZU GEBINDEARTIKEL`) AS SELECT mandant_id,
 art_id_basis,
 art_id_gebinde,
 umrech_zaehler,
 umrech_nenner,
 umrech_faktor,
 anz_einzel_art,
 anz_basis_art,
 dispo_fg,
 status_kz
FROM kfl_production_dbp_data.art_basis_gebinde_zu_2;