--==============================================================
-- Table: art_basis_gebinde_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_basis_gebinde_zu
   generated from Powerdesigner on Montag, 28. Oktober 2024 11:00:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_basis_gebinde_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id_basis BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Basisartikel'),
art_id_gebinde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gebindeartikel'),
umrech_zaehler BIGNUMERIC(38,0) OPTIONS(description='Zähler für die Umrechnung'),
umrech_nenner BIGNUMERIC(38,0) OPTIONS(description='Nenner für die Umrechnung'),
umrech_faktor NUMERIC(9,3) OPTIONS(description='Faktor für die Umrechnung'),
anz_basis_art BIGNUMERIC(38,0)
OPTIONS(description='Anzahl des Basisartikel im Gebinde. Ein Basisartikel kann aus einem oder mehreren Einzelartikeln bestehen. - Quelle: ZEKFLAKI.Y'),
anz_einzel_art BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Einzelartikel im Gebinde. - Quelle: ZEKFLAKI.ME_ASF'),
dispo_fg BIGNUMERIC(38,0) OPTIONS(description='Dispokennzeichen'),
status_kz STRING(1)
OPTIONS(description='Kennzeichen für den Status des Eintrags im Quellsystem: L = gelöscht, N = neu, A = Änderung. - Quelle: ZEKFLAKI.VWKZ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id_basis, art_id_gebinde) NOT ENFORCED
) OPTIONS(description='Zuordnungstabelle Basisartikel zu Gebindeartikel');