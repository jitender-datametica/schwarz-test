CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahre im Format JJJJMM.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
WUP_ID INTEGER NOT NULL
OPTIONS(description='Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.'),
NB_ID INTEGER NOT NULL OPTIONS(description='Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP_1).'),
DAT_GUELTIG_VON DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel_1 von einem Lieferanten in einer Filiale gültig sind.'),
DAT_GUELTIG_BIS DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel_1 von einem Lieferanten in einer Filiale gültig sind.'),
DAT_ABZUG DATE OPTIONS(description='Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
PREIS_EK_MEP NUMERIC(29,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.'),
PREIS_EK_NETTO_BNK NUMERIC(29,4)
OPTIONS(description='Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
PREIS_EK_EINSTANDSPREIS NUMERIC(29,4)
OPTIONS(description='Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK_1 nicht unterschritten werden.'),
PREIS_EK_NETTONETTO NUMERIC(29,4) OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..'),
PREIS_KMEP_EINH_O_FWU NUMERIC(29,4)
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PREIS_EK_MEP_VOR_FWU NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL'),
PRIMARY KEY (MANDANT_ID, KJMO, GP_ID, WUP_ID, NB_ID, ART_ID, DAT_GUELTIG_VON) NOT ENFORCED
)
OPTIONS(description='Bei der Tabelle handelt es sich um eine_1 periodic Snapshot_1 Tabelle auf Monatsbasis. Um Änderungen der Einkaufspreise durch Rückbewertungen verfolgen zu können soll hier ein monatlicher Abzug der Einkaufspreise aus den Tabellen art_gp_wup_zu_per_1 und art_umsatz_kmep_zu_per_1 eingefügt werden.');