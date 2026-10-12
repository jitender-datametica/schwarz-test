DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.BSCH_RECH_DET;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BSCH_RECH_DET (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BSCH_ID INTEGER NOT NULL OPTIONS(description='WE-/WA-ID - numerisch'),
BSCH_POS_ID INTEGER NOT NULL OPTIONS(description='Positions-ID   -  numerisch'),
DAT DATE NOT NULL OPTIONS(description='Bezugsdatum'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID wird hier - leider! in einem anderen Sinn als im übrigen Datenmodell verwendet - hier: Typ der Wareneingangsbewegung WE/WA 1, BA = 2, RBA = 3'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
GP_ID INTEGER NOT NULL OPTIONS(description='6 stellige Lieferanten-ID (ohne Pfandpositionen in Detailtabelle)'),
BA_ID INTEGER OPTIONS(description='Bela-/Rückbela-ID   numerisch = 0 bei WE/WA'),
BA_POS_ID INTEGER OPTIONS(description='Bela-/Rückbela-Positions-ID numerisch = 0 bei WE/WA'),
MENGE_RECH NUMERIC(18,3) OPTIONS(description='den Umsatz betreffende Menge'),
EK_N NUMERIC(18,4) OPTIONS(description='EK-Netto-Umsatz für den Artikel.'),
EK_NN NUMERIC(18,4) OPTIONS(description='Netto Netto Umsatz Gesamt für den Artikel.'),
STATUS INTEGER OPTIONS(description='Status: endgültig 3, gelöscht 2, vorläufig 1'),
EINKAUFSORGANISATION_ID INTEGER
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
VK_N NUMERIC(18,4) OPTIONS(description='VK-Netto-Umsatz'),
EK_MEP NUMERIC(18,4) OPTIONS(description='EK-Mep-Umsatz für den Artikel.'),
EK_KB NUMERIC(18,4) OPTIONS(description='EK-Kalkulationsbasis-Umsatz für den Artikel.'),
DIFF_MENGE_RECH_WE NUMERIC(18,3) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zur Menge des letzten vorläufigen Belegs gespeichert'),
DIFF_EK_N_WE NUMERIC(18,4) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum EKnetto des letzten vorläufigen Belegs gespeichert'),
DIFF_VK_N_WE NUMERIC(18,4) NOT NULL
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum VKnetto des letzten vorläufigen Belegs gespeichert'),
LAGERORT_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
LAGER_BEWART_ID STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung. Datentyp abweichend von der lookup-Tabelle gewählt'),
LOGKOSTEN NUMERIC(18,4)
OPTIONS(description='enthält Logistikkosten (menge aus bsch_rech_det * logistikkostenzuschlag aus art_gp_wup_zu_per)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, BSCH_ID, BSCH_POS_ID, DAT, BEWART_ID, ART_ID, WUP_ID, NB_ID) NOT ENFORCED
) CLUSTER BY WUP_ID, DAT
OPTIONS(description='TP2_AIS - Wareneingänge auf Positionsebene');