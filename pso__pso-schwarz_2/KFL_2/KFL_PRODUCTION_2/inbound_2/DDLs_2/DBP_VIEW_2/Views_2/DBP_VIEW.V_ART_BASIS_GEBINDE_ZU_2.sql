CREATE OR REPLACE VIEW DBP_VIEW.V_ART_BASIS_GEBINDE_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,art_id_basis                             COMMENT 'Basisartikel'
  ,art_id_gebinde                           COMMENT 'Gebindeartikel'
  ,umrech_zaehler                           COMMENT 'Zähler für die Umrechnung'
  ,umrech_nenner                            COMMENT 'Nenner für die Umrechnung'
  ,umrech_faktor                            COMMENT 'Faktor für die Umrechnung'
  ,anz_einzel_art                           COMMENT 'Anzahl der Einzelartikel im Gebinde. - Quelle: ZEKFLAKI.ME_ASF'
  ,anz_basis_art                            COMMENT 'Anzahl des Basisartikel im Gebinde. Ein Basisartikel kann aus einem oder mehreren Einzelartikeln bestehen. - Quelle: ZEKFLAKI.Y'
  ,dispo_fg                                 COMMENT 'Dispokennzeichen'
  ,status_kz                                COMMENT 'Kennzeichen für den Status_2 des Eintrags im Quellsystem: L = gelöscht, N = neu, A = Änderung. - Quelle: ZEKFLAKI.VWKZ'
)
COMMENT = 'Zuordnungstabelle Basisartikel zu Gebindeartikel'
 AS 
    SELECT 
        mandant_id,
        art_id_basis,
        art_id_gebinde,
        umrech_zaehler,
        umrech_nenner,
        umrech_faktor,
        anz_einzel_art,
        anz_basis_art,
        dispo_fg,
        status_kz

FROM DBP_DATA.ART_BASIS_GEBINDE_ZU_2 ;