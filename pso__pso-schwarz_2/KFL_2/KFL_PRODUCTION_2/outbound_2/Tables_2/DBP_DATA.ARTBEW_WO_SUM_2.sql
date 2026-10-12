--==============================================================
-- Table: artbew_wo_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_wo_sum_2
   generated from Powerdesigner on Mittwoch, 4. Juni 2025 18:23:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_wo_sum_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebs ID, bei Märkten immer = 0'),
kjwo_kl BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kaufland - Kalenderjahreswoche. Beginnt am 01.01. eines Jahres und endet am 31.12. unabhängig vom Wochentag. Die erste und die letzte Kalenderjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW.'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
aktion_id STRING(10) DEFAULT ' ' NOT NULL
OPTIONS(description='Aktion_2 aus den Kassendaten, die entweder unter einer bestimmten Bedingung gültig oder allgemeingültig ist. Entweder aus ods_promotion_2 (aktion_2 mit Voraussetzung) oder ods_bon_verkauf_2(aktion_2 ohne Voraussetzung). Referenz zur Tabelle aktion_2 + l_bonuskauf.'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bezugsweg der Ware (direkt vom Lieferanen = 1 oder über Zentrallager = 4).'),
ean_kasse NUMERIC(26,0) DEFAULT 0 NOT NULL OPTIONS(description='Von den Kassensystemen gelieferte EAN_2 / GTIN.'),
bewart_det_id BIGNUMERIC(38,0) DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'),
posten_id STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'),
standard_aktion_id STRING(10)
OPTIONS(description='Aktion_2, für die keine bestimmte Bedingung erfüllt werden muss, um den Rabatt zu bekommen. Aus ods_bon_verkauf_2 (Standardaktionsabverkäufe). Referenz zurTabelle aktion.            '),
menge BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein).'),
umsatz_netto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'),
diff_umsatz_netto_konz BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'),
umsatz_mwst_betrag BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
diff_umsatz_mwst_betrag_konz BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'),
ek_mep BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'),
ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_einstandspreis_konz BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'),
ek_nettonetto BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_nettonetto_konz BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
diff_ek_brutto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis brutto.'),
diff_ek_gld_konz BIGNUMERIC(38,4) OPTIONS(description='Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'),
diff_ek_kal_basis_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'),
diff_ek_mep_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'),
diff_ek_netto_bnk_konz BIGNUMERIC(38,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'),
diff_ek_netto_bnk_sachk_konz BIGNUMERIC(38,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'),
diff_ek_netto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis netto.'),
diff_logkostenzuschlag_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
ek_brutto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'),
ek_gld BIGNUMERIC(38,4)
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
ek_kal_basis BIGNUMERIC(38,4) OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'),
ek_netto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk_sachk BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'),
herst_id BIGNUMERIC(38,0) OPTIONS(description='Der Hersteller des Artikels (kann abweichend zum Lieferanten sein).'),
logkostenzuschlag BIGNUMERIC(38,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
promo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2).'),
bonusbasis BIGNUMERIC(38,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz BIGNUMERIC(38,4)
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
wup_bereinigt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche_2 nicht permanent geschlossen (zieht höchstens um).'),
pv_aktion BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 zustande gekommen ist.'),
pv_aktion_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 zustande gekommen ist.'),
pv_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Standard BBY zustande gekommen ist.'),
pv_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Standard BBY zustande gekommen ist.'),
pv_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_aktion_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_2 Aktion_2 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_2 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_2 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_2 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_2 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_2 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
pv_bonrabatt_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_2 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_2 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_2 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_2 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_2 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, wup_id, nb_id, bewart_id, mandant_id, gp_id, aktion_id, kjwo_kl, bezugsweg_id, ean_kasse,
 bewart_det_id, posten_id) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo_kl
OPTIONS(description='TP2 AIS - Aggregat Artbew_2 auf der Ebene Artikel_2 / Woche_2 / Markt.');