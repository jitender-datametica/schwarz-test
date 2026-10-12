CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew (mandant_id OPTIONS(description='Mandant im DWH.'), wup_id
OPTIONS(description='Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='Datum, Format YYYY-MM-DD.'), bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
gp_id OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'), art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
aktion_id
OPTIONS(description='Aktion aus den Kassendaten, die entweder unter einer bestimmten Bedingung gültig oder allgemeingültig ist. Entweder aus ods_promotion (aktion mit Voraussetzung) oder ods_bon_verkauf(aktion ohne Voraussetzung). Referenz zur Tabelle aktion + l_bonuskauf.'),
promo_fg OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2).'), ean_kasse
OPTIONS(description='Von den Kassensystemen gelieferte EAN / GTIN.'), standard_aktion_id
OPTIONS(description='Aktion, für die keine bestimmte Bedingung erfüllt werden muss, um den Rabatt zu bekommen. Aus ods_bon_verkauf (Standardaktionsabverkäufe). Referenz zurTabelle aktion.'),
einkaufsorganisation_id
OPTIONS(description='Aus EKORG. Die einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = (?) könnte es auch geben.'),
herst_id OPTIONS(description='Der Hersteller des Artikels (kann abweichend zum Lieferanten sein).'), mwst_id
OPTIONS(description='Schlüssel des Mehrwertsteuersatzes.'), menge
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel.'),
wrg
OPTIONS(description='Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. EUR. (Sollte eigentlich auch wrg_id heißen).'),
umrechnungskurs_hist OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '), umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'), diff_umsatz_netto_konz
OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'), umsatz_mwst_betrag
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
diff_umsatz_mwst_betrag_konz OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'), ek_brutto
OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'), diff_ek_brutto_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis brutto.'), ek_netto
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'), diff_ek_netto_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis netto.'), ek_nettonetto
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'), diff_ek_nettonetto_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'), ek_kal_basis
OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'), diff_ek_kal_basis_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'), ek_mep
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'), diff_ek_mep_konz
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'), ek_mep_vor_fwu
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_einstandspreis_konz OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'), logkostenzuschlag
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
diff_logkostenzuschlag_konz OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
bezugsweg_id OPTIONS(description='Bezugsweg der Ware (direkt vom Lieferanen = 1 oder über Zentrallager = 4).'),
ek_netto_bnk OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_konz
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'), ek_netto_bnk_sachk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_sachk_konz
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'),
posten_id
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'),
bq_findung_id OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.'), ek_gld
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
diff_ek_gld_konz OPTIONS(description='Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'), bonusbasis
OPTIONS(description='Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bewart_det_id OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'), wup_bereinigt_fg
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'),
pv_aktion
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_aktion_konz
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_kdn_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdn_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_kdp_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_aktion_kdp_bby_konz
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
pv_bonrabatt_bby_konz
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'))
OPTIONS(DESCRIPTION = `TP2 AIS - ARTIKEL BEWEGUNGSDATEN - MULTISET. BASIEREND AUF BONDATEN.`) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 bewart_id,
 gp_id,
 art_id,
 aktion_id,
 promo_fg,
 ean_kasse,
 standard_aktion_id,
 einkaufsorganisation_id,
 herst_id,
 mwst_id,
 menge,
 wrg,
 umrechnungskurs_hist,
 umsatz_netto,
 diff_umsatz_netto_konz,
 umsatz_mwst_betrag,
 diff_umsatz_mwst_betrag_konz,
 ek_brutto,
 diff_ek_brutto_konz,
 ek_netto,
 diff_ek_netto_konz,
 ek_nettonetto,
 diff_ek_nettonetto_konz,
 ek_kal_basis,
 diff_ek_kal_basis_konz,
 ek_mep,
 diff_ek_mep_konz,
 ek_mep_vor_fwu,
 ek_mep_vor_fwu_konz,
 einstandspreis,
 diff_einstandspreis_konz,
 logkostenzuschlag,
 diff_logkostenzuschlag_konz,
 bezugsweg_id,
 ek_netto_bnk,
 diff_ek_netto_bnk_konz,
 ek_netto_bnk_sachk,
 diff_ek_netto_bnk_sachk_konz,
 posten_id,
 bq_findung_id,
 ek_gld,
 diff_ek_gld_konz,
 bonusbasis,
 bonusbasis_konz,
 bewart_det_id,
 wup_bereinigt_fg,
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
FROM kfl_production_dbp_data.artbew;