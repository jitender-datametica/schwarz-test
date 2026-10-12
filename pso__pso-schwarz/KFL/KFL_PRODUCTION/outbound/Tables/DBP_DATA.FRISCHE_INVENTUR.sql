--==============================================================
-- Table: frische_inventur
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: frische_inventur
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.frische_inventur (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
anf_bestand_vk_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Anfangsbestand VK_Brutto (ohne Umlagerungen)'),
anf_bestand_ek_netto NUMERIC(18,2) NOT NULL
OPTIONS(description='Anfangsbestand EK_netto (ermittelt aus Endbestand Vormonat)'),
we_zl_vk_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Wareneingang aus Lieferung Zentrallager VK_Brutto'),
we_dezentral_vk_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Wareneingang aus Lieferung dezentral VK_Brutto'),
we_zl_ek_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Wareneingang aus Lieferung Zentrallager EK_netto'),
we_dezentral_ek_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Wareneingang aus Lieferung dezentral EK_netto'),
we_shop_in_shop_ek_netto NUMERIC(18,2) NOT NULL OPTIONS(description='nicht gewertete OuG WEs netto'),
abschrift_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Marktabschrift Brutto (AKZ 0010-0019 + 0021-0080)'),
werbe_abschrift_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Werbeabschrift Brutto (AKZ 0020) - ohne WG 001-002'),
end_bestand_vk_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Endbestand VK_Brutto'),
end_bestand_ek_netto NUMERIC(18,2) NOT NULL
OPTIONS(description='Endbestand EK_netto (berechnet aus VK_netto - kum. WE Spanne)'),
umsatz_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Umsatz Brutto (VK_Brutto)'),
umsatz_netto NUMERIC(9,2) NOT NULL OPTIONS(description='Umsatz netto (VK_netto)'),
erl_mind_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Erlösminderung Brutto (AKZ 0005-0009)'),
erl_mind_netto NUMERIC(9,2) NOT NULL OPTIONS(description='Bruch und Verderb - Erlösminderung netto (AKZ 0005-0009)'),
tkl_lieferung_vk_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Teilkostenlose Lieferung VK_Brutto (ZWSUM-8)'),
tkl_lieferung_ek_netto NUMERIC(18,2) NOT NULL
OPTIONS(description='Teilkostenlose Lieferung  EK_netto (ZWSUM-9) + VK-Brutto (ZWSUM-8)'),
we_zl_vk_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Wareneingang aus Lieferung Zentrallager VK Netto'),
we_shop_in_shop_vk_netto NUMERIC(18,2) NOT NULL OPTIONS(description='nicht gewertete OuG WEs VK Netto'),
geplant_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Das Flag gibt an, ob eine Frischeinventur geplant ist'),
durchgefuehrt_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Das Flag gibt an, ob eine Inventur durchgeführt wurde'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, arthiertyp_id, kjmo) NOT ENFORCED
)
OPTIONS(description='VIS - Die Tabelle dient der Erstellung des Berichts Frischeinventur und enthält verdichtete Daten aus mehreren großen Tabellen');