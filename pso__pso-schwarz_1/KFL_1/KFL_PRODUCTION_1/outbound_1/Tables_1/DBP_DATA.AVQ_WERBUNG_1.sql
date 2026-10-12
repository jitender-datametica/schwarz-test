--==============================================================
-- Table: avq_werbung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_werbung_1
   generated from Powerdesigner on Mittwoch, 8. Oktober 2025 08:32:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.avq_werbung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_aktion_von DATE NOT NULL OPTIONS(description='Werbung/Aktion_1 gültig ab'),
dat_aktion_bis DATE NOT NULL OPTIONS(description='Werbung/Aktion_1 gültig bis'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderwoche'),
anz_tage_aktion BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Tage Aktion_1'),
wtag_id_start BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag (Aktion_1 von)'),
wtag_id_ende BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag (Aktion_1 bis)'),
cluster_dauer_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Cluste für die Dauer, z. B. 1: 1 Tages-Aktionen, 2: 2-4 Tage (Wochenstart/-ende), 3: 5-9 Tage (Normal Wochenwerbung), 4: alles > 9 Tage'),
werbemittel_avq_top_prio_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Werbemittel (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenabschnitt_avq_top_prio_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Werbeflächenabschnitt (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenthema_avq_top_prio_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Werbeflächenthema (AVQ) mit der höchsten Priorität/ID'),
art_mutter_wb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 ID Werbemutter'),
posten_wb_id STRING(2) NOT NULL OPTIONS(description='Postenkennzeichen der Werbemutter'),
posten_id STRING(2) NOT NULL OPTIONS(description='Postenkennzeichen des Einzelartikels'),
pmr_top_art_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='TOP-Artikel_1 Flag (PMR)'),
werbeprozess_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='0 - keine Mengenberechnung, 1 - WBS TP1, 2 - WBS TP2, 3 - WBS TP1+2, 4 - F&R'),
aktionsklassifizierung_id STRING(10) NOT NULL
OPTIONS(description='SA/AF/BBY/irrelevant da gänzlich gelöscht oder gesperrt / k. Preisaktivierung…'),
aktionsklassifizierung_det_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prospekt/K-Card-only/BBY/Kombi'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_vk_aktion_brutto BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Verkaufspreis in Aktion_1'),
betrag_vk_kcard_brutto BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Verkaufspreis in Aktion_1 für K-CARD Kunden'),
betrag_vor_aktion_brutto BIGNUMERIC(38,3) OPTIONS(description='Verkaufspreis vor Aktion_1'),
faktor_flaki BIGNUMERIC(38,6) NOT NULL OPTIONS(description='Umrechnungsfaktor Flasche in Kiste. (Flasche/Kiste)'),
mhd_zeitraum BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum für diesen Artikel_1 in Tagen an (wird redundant aus der Tabelle art_1 geladen).'),
prz_min_restlaufzeit_lager BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird (wird redundant aus der Tabelle art_1 geladen).'),
menge_plan_wbs BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Planmenge aus WBS'),
menge_plan_upload BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Planmenge aus Upload '),
wbs_estimation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Estimation ID WBS'),
wbs_adjustment_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Adjustment ID WBS'),
menge_bestand_aktionsstart BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'),
menge_bestand_aktionsende BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Bestandsmenge am Ende der Aktion.'),
menge_ueberbestand BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Überbestand nach Aktion_1'),
menge_bestand_min_sicherheit BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per_1 (MARC_1).'),
menge_bestand_soll_max BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per_1 geladen).'),
menge_sollbestand BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per_1 geladen) (MARC_1).'),
anz_nullbestand_gesamt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
anz_nullbestand_tag1 BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag für den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
anz_nullbestand_tag1bis3 BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktionstagen für den Artikel_1 innerhalb der Kalenderwoche (kjwo).'),
anz_minusbestand_gesamt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
anz_minusbestand_tag1 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Minusbestand am ersten Tag_1 des Aktionszeitraums.'),
anz_minusbestand_tag1bis3 BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand während der ersten drei Tage des Aktionszeitraums.'),
anz_exc209_gesamt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Tage mit Nullbestand in Aktion_1'),
anz_exc209_tag1 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nullbestand am 1. Tag_1 (F&R Exception)'),
anz_exc209_tag1bis3 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Tage mit Nullbestand Tag_1 1-3 (F&R Exception)'),
anz_exc214_gesamt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Tage mit Negativbestand in Aktion_1 (F&R Exception)'),
anz_exc214_tag1 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Negativbestand am 1. Tag_1 (F&R Exception)'),
anz_exc214_tag1bis3 BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Tage mit Negativbestand Tag_1 1-3 (F&R Exception)'),
menge_gesamt BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Absatz gesamt in Basis-ME'),
betrag_umsatz_gesamt BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Umsatz netto gesamt'),
menge_historie_af BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
menge_nur_tag1 BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Absatz Tag_1 1 in Basis-ME'),
menge_tag_1_7bis13 BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Absatz Tag_1 1 bis 13 Uhr in Basis-ME'),
menge_we_gesamt BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Wareneingang in der Werbewoche.'),
menge_we_vor_aktion BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Wareneingang vor Aktion_1'),
menge_we_in_aktion BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis) NOT ENFORCED
)
OPTIONS(description='AVQ(Abverkaufsquote) Basistabelle - Kennzahlen und wichtige Attribute auf Ebene Markt/Artikel_1/Werbezeitraum');