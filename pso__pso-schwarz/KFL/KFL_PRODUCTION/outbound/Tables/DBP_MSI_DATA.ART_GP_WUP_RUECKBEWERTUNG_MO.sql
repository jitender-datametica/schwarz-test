--==============================================================
-- Table: art_gp_wup_rueckbewertung_mo
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_rueckbewertung_mo
   generated from Powerdesigner on Dienstag, 27. August 2024 16:55:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.art_gp_wup_rueckbewertung_mo (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahre im Format JJJJMM.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP).'),
dat_gueltig_von DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel von einem Lieferanten in einer Filiale gültig sind.'),
dat_gueltig_bis DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel von einem Lieferanten in einer Filiale gültig sind.'),
dat_abzug DATE OPTIONS(description='Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
preis_ek_mep BIGNUMERIC(38,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.'),
preis_ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL'),
preis_ek_netto_bnk BIGNUMERIC(38,4)
OPTIONS(description='Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
preis_ek_einstandspreis BIGNUMERIC(38,4)
OPTIONS(description='Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK nicht unterschritten werden.'),
preis_ek_nettonetto BIGNUMERIC(38,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..'),
preis_kmep_einh_o_fwu BIGNUMERIC(38,4)
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjmo, gp_id, wup_id, nb_id, art_id, dat_gueltig_von) NOT ENFORCED
)
OPTIONS(description='Bei der Tabelle handelt es sich um eine periodic Snapshot Tabelle auf Monatsbasis. Um Änderungen der Einkaufspreise durch Rückbewertungen verfolgen zu können soll hier ein monatlicher Abzug der Einkaufspreise aus den Tabellen art_gp_wup_zu_per und art_umsatz_kmep_zu_per eingefügt werden.');