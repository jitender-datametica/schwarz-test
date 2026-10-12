CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markt_lagerbuch (mandant_id OPTIONS(description='Mandant im DWH'),
wup_id OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel verkauft wird.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
stellplatz_nr OPTIONS(description='Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3'), markt_lagerbereich_id
OPTIONS(description='ID des Lagerbereichs in der Filiale.'), art_id
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
dat_mhd OPTIONS(description='Mindesthaltbarkeitsdatum des Artikels.'), betrag_vk_brutto
OPTIONS(description='VK Brutto Einzelpreis des Artikels.'), dat_lagerbuch
OPTIONS(description='Datum der Lagerbuchdaten.'), menge_lagerbestand_stellplatz
OPTIONS(description='Lagerbestand auf dem Stellplatz.'), menge_lagerbestand_gesamt
OPTIONS(description='Gesamter Bestand im Filiallager.'), menge_filialbestand
OPTIONS(description='Gesamter Filialbestand. Enthält die Summe des aktuellen Lagerbestands und des Bestands im Verkaufsregal für die zugehörige Filiale.'),
menge_opt_bestand OPTIONS(description='Maximaler oder optischer Bestand des Artikels im Regal.'), rate_verraeumung
OPTIONS(description='Für jeden Artikel im Lager wird geprüft wieviel % des Bestandes ins Verkaufsregal verräumt werden können. Hierfür wird aus dem Filialbestand minus Lagerbestand minus Wareneingangs-Bestand der Regalbestand ermittelt. '),
dat_aenderung OPTIONS(description='letzte Änderung auf dem Stellplatz.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT EINEN ÜBERBLICK ÜBER DIE BESTANDSITUATION IN EINER FILIALE (LAGER, VERKAUFSFLÄCHE). SIE WIRD AUS DEM SYSTEM COUCHBASE VERSORGT.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 stellplatz_nr,
 markt_lagerbereich_id,
 art_id,
 dat_mhd,
 betrag_vk_brutto,
 dat_lagerbuch,
 menge_lagerbestand_stellplatz,
 menge_lagerbestand_gesamt,
 menge_filialbestand,
 menge_opt_bestand,
 rate_verraeumung,
 dat_aenderung,
 wrg_id
FROM kfl_production_dbp_data.markt_lagerbuch;