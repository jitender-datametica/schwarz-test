--==============================================================
-- Table: artbew_zek_mo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_zek_mo_sum_1
   generated from Powerdesigner on Mittwoch, 4. Juni 2025 18:23:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_zek_mo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat.'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
bewart_det_id BIGNUMERIC(38,0) DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'),
posten_id STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_1, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch. So gesehen eine_1 überflüssige ID (?).'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_1 '),
menge BIGNUMERIC(38,4)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_1 reduziert um zurückgegebene Artikel.'),
umsatz_netto BIGNUMERIC(38,4) OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag.'),
diff_umsatz_netto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Umsatz netto.'),
umsatz_mwst_betrag BIGNUMERIC(38,4)
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_1 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
diff_umsatz_mwst_betrag_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'),
ek_brutto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_brutto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis brutto.'),
ek_netto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis netto.'),
ek_nettonetto BIGNUMERIC(38,4) OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_nettonetto_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis nettonetto.'),
ek_kal_basis BIGNUMERIC(38,4) OPTIONS(description='Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_kal_basis_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'),
ek_mep BIGNUMERIC(38,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_mep_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'),
ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
ek_mep_vor_fwu_konz BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'),
einstandspreis BIGNUMERIC(38,4) OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
diff_einstandspreis_konz BIGNUMERIC(38,4) OPTIONS(description='Von der Konzernwährung abweichender Einstandspreis.'),
logkostenzuschlag BIGNUMERIC(38,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
diff_logkostenzuschlag_konz BIGNUMERIC(38,4)
OPTIONS(description='Von der Konzernwährung abweichender Logistikkostenzuschlag.'),
ek_netto_bnk BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_konz BIGNUMERIC(38,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'),
ek_netto_bnk_sachk BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'),
diff_ek_netto_bnk_sachk_konz BIGNUMERIC(38,4)
OPTIONS(description='Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'),
ek_gld BIGNUMERIC(38,4)
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
diff_ek_gld_konz BIGNUMERIC(38,4) OPTIONS(description='Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'),
bonusbasis BIGNUMERIC(38,4)
OPTIONS(description='Die Bonusbasis bildet für Artikel_1 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
bonusbasis_konz BIGNUMERIC(38,4)
OPTIONS(description='Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel_1 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'),
pv_aktion BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 zustande gekommen ist.'),
pv_aktion_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 zustande gekommen ist.'),
pv_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Standard BBY zustande gekommen ist.'),
pv_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Standard BBY zustande gekommen ist.'),
pv_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'),
pv_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'),
pv_aktion_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdn_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'),
pv_aktion_kdp_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_aktion_kdp_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'),
pv_bonrabatt_bby BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_1 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_1 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_1 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_1 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_1 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
pv_bonrabatt_bby_konz BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_1 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_1 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_1 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_1 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_1 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zek_id, kjmo, bewart_id, wup_id, nb_id, posten_id, bewart_det_id) NOT ENFORCED
) CLUSTER BY kjmo
OPTIONS(description='TP2 AIS - Aggregat Artbew_1 auf der Ebene ZEK_1/Monat_1/Markt - Multiset');