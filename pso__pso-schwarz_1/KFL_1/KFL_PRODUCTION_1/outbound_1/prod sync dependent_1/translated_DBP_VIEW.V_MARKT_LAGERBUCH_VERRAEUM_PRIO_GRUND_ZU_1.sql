CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markt_lagerbuch_verraeum_prio_grund_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), wup_id
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
stellplatz_nr OPTIONS(description='Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3'), markt_lagerbereich_id
OPTIONS(description='ID des Lagerbereichs in der Filiale.'), art_id
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_mhd OPTIONS(description='Mindesthaltbarkeitsdatum des Artikels.'), betrag_vk_brutto
OPTIONS(description='VK_1 Brutto Einzelpreis des Artikels.'), dat_lagerbuch
OPTIONS(description='Datum der Lagerbuchdaten.'), verraeumung_prio_grund_id
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR')) AS SELECT mandant_id,
 wup_id,
 nb_id,
 stellplatz_nr,
 markt_lagerbereich_id,
 art_id,
 dat_mhd,
 betrag_vk_brutto,
 dat_lagerbuch,
 verraeumung_prio_grund_id,
 wrg_id
FROM kfl_production_dbp_data.markt_lagerbuch_verraeum_prio_grund_zu_1;