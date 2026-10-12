--==============================================================
-- Table: inventur_bewertung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_bewertung_2
   generated from Powerdesigner on Dienstag, 30. April 2024 13:22:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_BEWERTUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   inventurart_id                      INTEGER     NOT NULL COMMENT 'Inventurart (international nicht identisch)',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   dat_preis                           DATE             NOT NULL COMMENT 'Datum der Inventurbewertung. Das Preisdatum wird benötigt, um die Inventur_2 mit dem zu diesem Zeitpunkt gültigen Preis zu bewerten. Inventurdifferenzen können mehrmals im Jahr bewertet werden.',
   beleg_erfasser_id                   VARCHAR(20)      NOT NULL COMMENT 'ID des Beleg-Erfassers. Kann Batch-Usernamen oder FB enthalten. Aus Datenschutzgründen darf in den Bewegungsdaten nur der Fachbereich des Erfassers abgebildet werden.',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstelldatum des Datensatzes im Quellsystem.',
   zeit_inventur                       TIME(0)          NOT NULL COMMENT 'Uhrzeit der Inventur.',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   owg_id                              INTEGER     NOT NULL COMMENT 'ID der Oberwarengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_2-Hierarchie-Typ-ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.',
   mwst_id                             INTEGER     NOT NULL COMMENT 'Mehrwertsteuersatz-ID (<> Mehrwertsteuersatz!)',
   rate_steuersatz                     NUMBER(29,2)     NOT NULL COMMENT 'Rate des Mehrwertsteuersatzes.',
   inventur_typ_txt                    VARCHAR(50)      NOT NULL COMMENT 'Freitext zur Möglichkeit einer detaillierteren Kategorisierung der Inventurarten.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   menge_bme_inventur_diff             NUMBER(29,3)     NOT NULL COMMENT 'Gesamtmenge der ermittelten und verdichteten Inventurdifferenz in Basismengeneinheit auf Ebende Filiale und Artikel.',
   menge_bme_inventur_diebstahl        NUMBER(29,3)     NOT NULL COMMENT 'Menge der durch Diebstahl verursachten Inventurdifferenz in Basismengeneinheit auf Ebene Filiale und Artikel.',
   preis_vk_brutto                     NUMBER(29,4)     NOT NULL COMMENT 'Brutto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.',
   preis_vk_netto                      NUMBER(29,4)     NOT NULL COMMENT 'Netto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.',
   preis_vk_brutto_korrigiert          NUMBER(29,4)     NOT NULL COMMENT 'Korrigierter Brutto-Verkaufspreis des Artikels. Es kann vorkommen, dass dem betrag_vk_brutto Fehler unterliegen. In diesen Fällen kann vom Fachbereich ein korrigierter Betrag angegeben werden. Tritt dieser Fall ein, ist die manuell korrigierte Eingabe führend.',
   betrag_vk_netto_inventur_diff       NUMBER(29,4)     NOT NULL COMMENT 'Mit dem Netto-Verkaufspreis bewertete Inventurdifferenz: menge_inventur_diff * betrag_vk_netto',
   betrag_vk_netto_inventur_diebstahl  NUMBER(29,4)     NOT NULL COMMENT 'Mit dem Netto Verkaufspreis bewertete durch Diebstahl verursachte Inventurdifferenz: menge_inventur_diebstahl * betrag_vk_netto.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_BEWERTUNG PRIMARY KEY (mandant_id, inventurart_id, wup_id, nb_id, art_id, dat_preis) NOT ENFORCED
)  COMMENT = 'Tabelle enthält bewertete Inventurdaten auf Ebene Artikel_2 - Filiale. Dazu werden die Positionen in den Materialbelegen auf diese Ebene verdichtet. Dies ist notwendig um verschiedene Besonderheiten abzubilden (bspw. Umzüge, Filialumgliederung, Kleingebindeaufschlag, Treueartikel). Aktuelle Quelltabelle in SAP: ZWWX_INVWERT.';