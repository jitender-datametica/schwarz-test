--==============================================================
-- Table: art_basis_gebinde_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_basis_gebinde_zu_2
   generated from Powerdesigner on Montag, 28. Oktober 2024 11:00:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BASIS_GEBINDE_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id_basis                        INTEGER     NOT NULL COMMENT 'Basisartikel',
   art_id_gebinde                      INTEGER     NOT NULL COMMENT 'Gebindeartikel',
   umrech_zaehler                      INTEGER     COMMENT 'Zähler für die Umrechnung',
   umrech_nenner                       INTEGER     COMMENT 'Nenner für die Umrechnung',
   umrech_faktor                       NUMBER(29,3)      COMMENT 'Faktor für die Umrechnung',
   anz_basis_art                       INTEGER     COMMENT 'Anzahl des Basisartikel im Gebinde. Ein Basisartikel kann aus einem oder mehreren Einzelartikeln bestehen. - Quelle: ZEKFLAKI.Y',
   anz_einzel_art                      INTEGER     COMMENT 'Anzahl der Einzelartikel im Gebinde. - Quelle: ZEKFLAKI.ME_ASF',
   dispo_fg                            INTEGER     COMMENT 'Dispokennzeichen',
   status_kz                           VARCHAR(1)       COMMENT 'Kennzeichen für den Status_2 des Eintrags im Quellsystem: L = gelöscht, N = neu, A = Änderung. - Quelle: ZEKFLAKI.VWKZ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BASIS_GEBINDE_ZU PRIMARY KEY (mandant_id, art_id_basis, art_id_gebinde) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle Basisartikel zu Gebindeartikel';
