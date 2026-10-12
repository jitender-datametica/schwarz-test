create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat_2 eines Kalenderjahre im Format JJJJMM.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP_2).',
	DAT_GUELTIG_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel_2 von einem Lieferanten in einer Filiale gültig sind.',
	DAT_GUELTIG_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel_2 von einem Lieferanten in einer Filiale gültig sind.',
	DAT_ABZUG DATE COMMENT 'Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	PREIS_EK_MEP NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.',
	PREIS_EK_NETTO_BNK NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
	PREIS_EK_EINSTANDSPREIS NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK_2 nicht unterschritten werden.',
	PREIS_EK_NETTONETTO NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..',
	PREIS_KMEP_EINH_O_FWU NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	PREIS_EK_MEP_VOR_FWU NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL',
	constraint PK_ART_GP_WUP_RUECKBEWERTUNG_MO primary key (MANDANT_ID, KJMO, GP_ID, WUP_ID, NB_ID, ART_ID, DAT_GUELTIG_VON)
)COMMENT='Bei der Tabelle handelt es sich um eine_2 periodic Snapshot_2 Tabelle auf Monatsbasis. Um Änderungen der Einkaufspreise durch Rückbewertungen verfolgen zu können soll hier ein monatlicher Abzug der Einkaufspreise aus den Tabellen art_gp_wup_zu_per_2 und art_umsatz_kmep_zu_per_2 eingefügt werden.'
;