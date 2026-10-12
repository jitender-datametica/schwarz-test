CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_vw_sum_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'), dat
OPTIONS(description='Datum des Reklamationsvorgangs.'), bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
gp_id OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'), art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
vw_id OPTIONS(description='ID des Vertriebsweges.'), bezugsweg_id
OPTIONS(description='Bezugsweg der Ware (direkt vom Lieferanen = 1 oder über Zentrallager = 4).'), wup_bereinigt_fg
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche_2 nicht permanent geschlossen (zieht höchstens um).'),
menge OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein).'),
umsatz_netto OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'), umsatz_mwst_betrag
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
ek_mep OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'), ek_mep_vor_fwu
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'), ek_nettonetto
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), umrechnungskurs_hist
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '), diff_einstandspreis_konz
OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'), diff_ek_brutto_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis brutto.'), diff_ek_gld_konz
OPTIONS(description='Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'), diff_ek_kal_basis_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'), diff_ek_mep_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'), diff_ek_netto_bnk_konz
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'),
diff_ek_netto_bnk_sachk_konz
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'),
diff_ek_netto_konz OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis netto.'),
diff_ek_nettonetto_konz OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'),
diff_logkostenzuschlag_konz OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
diff_umsatz_mwst_betrag_konz OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'),
diff_umsatz_netto_konz OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'), ean_kasse
OPTIONS(description='Von den Kassensystemen gelieferte EAN_2 / GTIN.'), ek_brutto
OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'), ek_gld
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
ek_kal_basis OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'), ek_netto
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'), ek_netto_bnk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk_sachk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'),
herst_id OPTIONS(description='Der Hersteller des Artikels (kann abweichend zum Lieferanten sein).'), logkostenzuschlag
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
bonusbasis
OPTIONS(description='Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bewart_det_id OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'), pv_aktion
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 zustande gekommen ist.'),
pv_aktion_konz
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 zustande gekommen ist.'),
pv_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Standard BBY zustande gekommen ist.'),
pv_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Standard BBY zustande gekommen ist.'),
pv_kdn_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdn_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_kdp_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_aktion_kdp_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_2 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_2 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_2 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_2 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_2 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
pv_bonrabatt_bby_konz
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_2 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_2 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_2 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_2 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_2 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'))
OPTIONS(DESCRIPTION = `TP2 AIS - AGGREGAT ARTBEW_2 AUF DER EBENE ARTIKEL_2/TAG_2/VERTRIEBSWEG`) AS SELECT mandant_id,
 dat,
 bewart_id,
 gp_id,
 art_id,
 vw_id,
 bezugsweg_id,
 wup_bereinigt_fg,
 menge,
 umsatz_netto,
 umsatz_mwst_betrag,
 ek_mep,
 ek_mep_vor_fwu,
 ek_mep_vor_fwu_konz,
 einstandspreis,
 ek_nettonetto,
 wrg_id,
 umrechnungskurs_hist,
 diff_einstandspreis_konz,
 diff_ek_brutto_konz,
 diff_ek_gld_konz,
 diff_ek_kal_basis_konz,
 diff_ek_mep_konz,
 diff_ek_netto_bnk_konz,
 diff_ek_netto_bnk_sachk_konz,
 diff_ek_netto_konz,
 diff_ek_nettonetto_konz,
 diff_logkostenzuschlag_konz,
 diff_umsatz_mwst_betrag_konz,
 diff_umsatz_netto_konz,
 ean_kasse,
 ek_brutto,
 ek_gld,
 ek_kal_basis,
 ek_netto,
 ek_netto_bnk,
 ek_netto_bnk_sachk,
 herst_id,
 logkostenzuschlag,
 bonusbasis,
 bonusbasis_konz,
 bewart_det_id,
 pv_aktion,
 pv_aktion_konz,
 pv_bby,
 pv_bby_konz,
 pv_kdn_bby,
 pv_kdn_bby_konz,
 pv_kdp_bby,
 pv_kdp_bby_konz,
 pv_aktion_bby,
 pv_aktion_bby_konz,
 pv_aktion_kdn_bby,
 pv_aktion_kdn_bby_konz,
 pv_aktion_kdp_bby,
 pv_aktion_kdp_bby_konz,
 pv_bonrabatt_bby,
 pv_bonrabatt_bby_konz
FROM kfl_production_dbp_data.artbew_vw_sum_2;