DROP TABLE IF EXISTS kfl_production_dbp_data.artbew_wg_tp2_sum;
CREATE OR REPLACE TABLE kfl_production_dbp_data.artbew_wg_tp2_sum (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT.'),
wg_id INTEGER NOT NULL OPTIONS(description='Warengruppe.'),
wup_id INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='ArtikelHierarchieTyp-ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
bewart_id INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
posten_id STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem Artikelstamm, da dort nicht historisiert.'),
menge NUMERIC(29,4)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein).'),
menge_ohne_wg_erf_art NUMERIC(29,4) OPTIONS(description='Menge vermindert um die Warengruppenerfassungsartikel.'),
umsatz_netto NUMERIC(29,4) OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'),
diff_umsatz_netto_konz NUMERIC(29,4) OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'),
umsatz_mwst_betrag NUMERIC(29,4)
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
diff_umsatz_mwst_betrag_konz NUMERIC(29,4)
OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'),
ek_brutto NUMERIC(29,4) OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_brutto_konz NUMERIC(29,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis brutto.'),
ek_netto NUMERIC(29,4) OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_konz NUMERIC(29,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis netto.'),
ek_nettonetto NUMERIC(29,4) OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_nettonetto_konz NUMERIC(29,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'),
ek_kal_basis NUMERIC(29,4) OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_kal_basis_konz NUMERIC(29,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'),
ek_mep NUMERIC(29,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_mep_konz NUMERIC(29,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'),
einstandspreis NUMERIC(29,4) OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_einstandspreis_konz NUMERIC(29,4) OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'),
logkostenzuschlag NUMERIC(29,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
diff_logkostenzuschlag_konz NUMERIC(29,4)
OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
ek_netto_bnk NUMERIC(29,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_konz NUMERIC(29,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'),
ek_netto_bnk_sachk NUMERIC(29,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_sachk_konz NUMERIC(29,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'),
diff_ek_gld_konz NUMERIC(29,4) OPTIONS(description='Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'),
ek_gld NUMERIC(29,4)
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
bewart_det_id INTEGER DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'),
pv_aktion NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_kdn_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
ek_mep_vor_fwu NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen\"alten\" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen\"alten\" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
bonusbasis NUMERIC(29,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz NUMERIC(29,4)
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
pv_bonrabatt_bby NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
wup_bereinigt_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die\"bereinigte\" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'),
pv_aktion_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'),
pv_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'),
pv_kdn_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby_konz NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
umrechnungskurs_hist NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
PRIMARY KEY (mandant_id, dat, wg_id, wup_id, nb_id, arthiertyp_id, bewart_id, posten_id) NOT ENFORCED
) CLUSTER BY dat
OPTIONS(description='TP2 AIS - Verdichtungstabelle für die Artikelbewegungen auf Tages- und Warengruppenebene');