DROP TABLE IF EXISTS kfl_production_dbp_data.bsch_rech_det_1;
CREATE OR REPLACE TABLE kfl_production_dbp_data.bsch_rech_det_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bsch_id INTEGER NOT NULL OPTIONS(description='WE-/WA-ID - numerisch'),
bsch_pos_id INTEGER NOT NULL OPTIONS(description='Positions-ID   -  numerisch'),
dat DATE NOT NULL OPTIONS(description='Bezugsdatum'),
bewart_id INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID wird hier - leider! in einem anderen Sinn als im übrigen Datenmodell verwendet - hier: Typ der Wareneingangsbewegung WE/WA 1, BA = 2, RBA = 3'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gp_id INTEGER NOT NULL OPTIONS(description='6 stellige Lieferanten-ID (ohne Pfandpositionen in Detailtabelle)'),
ba_id INTEGER OPTIONS(description='Bela-/Rückbela-ID   numerisch = 0 bei WE/WA'),
ba_pos_id INTEGER OPTIONS(description='Bela-/Rückbela-Positions-ID numerisch = 0 bei WE/WA'),
menge_rech NUMERIC(18,3) OPTIONS(description='den Umsatz betreffende Menge'),
ek_n NUMERIC(18,4) OPTIONS(description='EK-Netto-Umsatz für den Artikel.'),
ek_nn NUMERIC(18,4) OPTIONS(description='Netto Netto Umsatz Gesamt für den Artikel.'),
status_1 INTEGER OPTIONS(description='Status_1: endgültig 3, gelöscht 2, vorläufig 1'),
einkaufsorganisation_id INTEGER
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
vk_n NUMERIC(18,4) OPTIONS(description='VK_1-Netto-Umsatz'),
ek_mep NUMERIC(18,4) OPTIONS(description='EK-Mep-Umsatz für den Artikel.'),
ek_kb NUMERIC(18,4) OPTIONS(description='EK-Kalkulationsbasis-Umsatz für den Artikel.'),
diff_menge_rech_we NUMERIC(18,3) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zur Menge des letzten vorläufigen Belegs gespeichert'),
diff_ek_n_we NUMERIC(18,4) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum EKnetto des letzten vorläufigen Belegs gespeichert'),
diff_vk_n_we NUMERIC(18,4) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum VKnetto des letzten vorläufigen Belegs gespeichert'),
lagerort_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
lager_bewart_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung. Datentyp abweichend von der lookup-Tabelle gewählt'),
logkosten NUMERIC(18,4)
OPTIONS(description='enthält Logistikkosten (menge aus bsch_rech_det_1 * logistikkostenzuschlag aus art_gp_wup_zu_per_1)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (mandant_id, bsch_id, bsch_pos_id, dat, bewart_id, art_id, wup_id, nb_id) NOT ENFORCED
) CLUSTER BY wup_id, dat
OPTIONS(description='TP2_AIS - Wareneingänge auf Positionsebene');