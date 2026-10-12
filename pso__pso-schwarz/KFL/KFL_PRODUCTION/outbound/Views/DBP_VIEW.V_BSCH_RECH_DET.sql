CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bsch_rech_det (mandant_id OPTIONS(description='Mandant im DWH'),
bsch_id OPTIONS(description='WE-/WA-ID - numerisch'), bsch_pos_id OPTIONS(description='Positions-ID   -  numerisch'),
dat OPTIONS(description='Bezugsdatum'), bewart_id
OPTIONS(description='Bewegungsart ID wird hier - leider! in einem anderen Sinn als im übrigen Datenmodell verwendet - hier: Typ der Wareneingangsbewegung WE/WA 1, BA = 2, RBA = 3'),
art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), gp_id
OPTIONS(description='6 stellige Lieferanten-ID (ohne Pfandpositionen in Detailtabelle)'), ba_id
OPTIONS(description='Bela-/Rückbela-ID   numerisch= 0 bei WE/WA'), ba_pos_id
OPTIONS(description='Bela-/Rückbela-Positions-ID   numerisch= 0 bei WE/WA '), menge_rech
OPTIONS(description='den Umsatz betreffende Menge'), ek_n OPTIONS(description='EK-Netto-Umsatz für den Artikel.'), ek_nn
OPTIONS(description='Netto Netto Umsatz Gesamt für den Artikel.'), status
OPTIONS(description='Status: endgültig 3, gelöscht 2, vorläufig 1'), einkaufsorganisation_id
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
vk_n OPTIONS(description='VK-Netto-Umsatz'), ek_mep OPTIONS(description='EK-Mep-Umsatz für den Artikel.'), ek_kb
OPTIONS(description='EK-Kalkulationsbasis-Umsatz für den Artikel.'), diff_menge_rech_we
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zur Menge des letzten vorläufigen Belegs gespeichert'),
diff_ek_n_we
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum EKnetto des letzten vorläufigen Belegs gespeichert'),
diff_vk_n_we
OPTIONS(description='Bei endgültigen Belegen wird hier die Differenz zum VKnetto des letzten vorläufigen Belegs gespeichert'),
lagerort_id OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
lager_bewart_id
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung. Datentyp abweichend von der lookup-Tabelle gewählt'),
logkosten
OPTIONS(description='enthält Logistikkosten (menge aus bsch_rech_det * logistikkostenzuschlag aus art_gp_wup_zu_per)'),
wrg_id OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), betrag_ek_mep_vor_fwu
OPTIONS(description='Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'))
OPTIONS(DESCRIPTION = `TP2_AIS - Wareneingänge auf Positionsebene`) AS SELECT mandant_id,
 bsch_id,
 bsch_pos_id,
 dat,
 bewart_id,
 art_id,
 wup_id,
 nb_id,
 gp_id,
 ba_id,
 ba_pos_id,
 menge_rech,
 ek_n,
 ek_nn,
 status,
 einkaufsorganisation_id,
 vk_n,
 ek_mep,
 ek_kb,
 diff_menge_rech_we,
 diff_ek_n_we,
 diff_vk_n_we,
 lagerort_id,
 lager_bewart_id,
 logkosten,
 wrg_id,
 betrag_ek_mep_vor_fwu
FROM kfl_production_dbp_data.bsch_rech_det;