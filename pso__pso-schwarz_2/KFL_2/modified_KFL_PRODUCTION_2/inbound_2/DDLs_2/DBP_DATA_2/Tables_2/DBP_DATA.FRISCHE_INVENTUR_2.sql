--==============================================================
-- Table: frische_inventur_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: frische_inventur_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FRISCHE_INVENTUR_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahresmonat',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   anf_bestand_vk_brutto               NUMBER(29,2)     NOT NULL COMMENT 'Anfangsbestand VK_Brutto (ohne Umlagerungen)',
   anf_bestand_ek_netto                NUMBER(29,2)     NOT NULL COMMENT 'Anfangsbestand EK_netto (ermittelt aus Endbestand Vormonat)',
   we_zl_vk_brutto                     NUMBER(29,2)     NOT NULL COMMENT 'Wareneingang aus Lieferung Zentrallager VK_Brutto',
   we_dezentral_vk_brutto              NUMBER(29,2)     NOT NULL COMMENT 'Wareneingang aus Lieferung dezentral VK_Brutto',
   we_zl_ek_netto                      NUMBER(29,2)     NOT NULL COMMENT 'Wareneingang aus Lieferung Zentrallager EK_netto',
   we_dezentral_ek_netto               NUMBER(29,2)     NOT NULL COMMENT 'Wareneingang aus Lieferung dezentral EK_netto',
   we_shop_in_shop_ek_netto            NUMBER(29,2)     NOT NULL COMMENT 'nicht gewertete OuG WEs netto',
   abschrift_brutto                    NUMBER(29,2)      NOT NULL COMMENT 'Marktabschrift Brutto (AKZ 0010-0019 + 0021-0080)',
   werbe_abschrift_brutto              NUMBER(29,2)      NOT NULL COMMENT 'Werbeabschrift Brutto (AKZ 0020) - ohne WG 001-002',
   end_bestand_vk_brutto               NUMBER(29,2)     NOT NULL COMMENT 'Endbestand VK_Brutto',
   end_bestand_ek_netto                NUMBER(29,2)     NOT NULL COMMENT 'Endbestand EK_netto (berechnet aus VK_netto - kum. WE Spanne)',
   umsatz_brutto                       NUMBER(29,2)      NOT NULL COMMENT 'Umsatz Brutto (VK_Brutto)',
   umsatz_netto                        NUMBER(29,2)      NOT NULL COMMENT 'Umsatz netto (VK_netto)',
   erl_mind_brutto                     NUMBER(29,2)      NOT NULL COMMENT 'Erlösminderung Brutto (AKZ 0005-0009)',
   erl_mind_netto                      NUMBER(29,2)      NOT NULL COMMENT 'Bruch und Verderb - Erlösminderung netto (AKZ 0005-0009)',
   tkl_lieferung_vk_brutto             NUMBER(29,2)     NOT NULL COMMENT 'Teilkostenlose Lieferung VK_Brutto (ZWSUM-8)',
   tkl_lieferung_ek_netto              NUMBER(29,2)     NOT NULL COMMENT 'Teilkostenlose Lieferung  EK_netto (ZWSUM-9) + VK_2-Brutto (ZWSUM-8)',
   we_zl_vk_netto                      NUMBER(29,2)     NOT NULL COMMENT 'Wareneingang aus Lieferung Zentrallager VK_2 Netto',
   we_shop_in_shop_vk_netto            NUMBER(29,2)     NOT NULL COMMENT 'nicht gewertete OuG WEs VK_2 Netto',
   geplant_fg                          INTEGER     NOT NULL COMMENT 'Das Flag gibt an, ob eine_2 Frischeinventur geplant ist',
   durchgefuehrt_fg                    INTEGER     NOT NULL COMMENT 'Das Flag gibt an, ob eine_2 Inventur_2 durchgeführt wurde',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FRISCHE_INVENTUR PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, arthiertyp_id, kjmo) NOT ENFORCED
)  COMMENT = 'VIS - Die Tabelle dient der Erstellung des Berichts Frischeinventur und enthält verdichtete Daten aus mehreren großen Tabellen';

