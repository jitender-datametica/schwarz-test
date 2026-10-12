--==============================================================
-- Table: artbew_vw_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_vw_sum
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_vw_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
dat DATE NOT NULL OPTIONS(description='Datum des Reklamationsvorgangs.'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges.'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bezugsweg der Ware (direkt vom Lieferanen = 1 oder über Zentrallager = 4).'),
wup_bereinigt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'),
menge BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein).'),
umsatz_netto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'),
umsatz_mwst_betrag BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
ek_mep BIGNUMERIC(38,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'),
ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis BIGNUMERIC(38,4) OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
ek_nettonetto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
diff_einstandspreis_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'),
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
diff_ek_nettonetto_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'),
diff_logkostenzuschlag_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
diff_umsatz_mwst_betrag_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'),
diff_umsatz_netto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'),
ean_kasse NUMERIC(26,0) DEFAULT 0 NOT NULL OPTIONS(description='Von den Kassensystemen gelieferte EAN / GTIN.'),
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
bonusbasis BIGNUMERIC(38,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz BIGNUMERIC(38,4)
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bewart_det_id BIGNUMERIC(38,0) DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'),
pv_aktion BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_aktion_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_aktion_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
pv_bonrabatt_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, vw_id, bewart_id, gp_id, dat, bezugsweg_id, wup_bereinigt_fg) NOT ENFORCED
) CLUSTER BY dat
OPTIONS(description='TP2 AIS - Aggregat Artbew auf der Ebene Artikel/Tag/Vertriebsweg');