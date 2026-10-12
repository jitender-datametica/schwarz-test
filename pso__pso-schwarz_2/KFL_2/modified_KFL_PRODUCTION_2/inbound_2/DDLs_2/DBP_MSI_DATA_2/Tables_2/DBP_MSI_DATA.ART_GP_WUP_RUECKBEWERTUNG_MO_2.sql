--==============================================================
-- Table: art_gp_wup_rueckbewertung_mo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_rueckbewertung_mo_2
   generated from Powerdesigner on Dienstag, 27. August 2024 16:55:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat_2 eines Kalenderjahre im Format JJJJMM.',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   wup_id                              INTEGER     NOT NULL COMMENT 'Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP_2).',
   dat_gueltig_von                     DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel_2 von einem Lieferanten in einer Filiale gültig sind.',
   dat_gueltig_bis                     DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel_2 von einem Lieferanten in einer Filiale gültig sind.',
   dat_abzug                           DATE             COMMENT 'Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   preis_ek_mep                        NUMBER(29,4)     COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.',
   preis_ek_mep_vor_fwu                NUMBER(29,4)     COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL',
   preis_ek_netto_bnk                  NUMBER(29,4)     COMMENT 'Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.',
   preis_ek_einstandspreis             NUMBER(29,4)     COMMENT 'Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK_2 nicht unterschritten werden.',
   preis_ek_nettonetto                 NUMBER(29,4)     COMMENT 'EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..',
   preis_kmep_einh_o_fwu               NUMBER(29,4)     COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_WUP_RUECKBEWERTUNG_MO PRIMARY KEY (mandant_id, kjmo, gp_id, wup_id, nb_id, art_id, dat_gueltig_von) NOT ENFORCED
)  COMMENT = 'Bei der Tabelle handelt es sich um eine_2 periodic Snapshot_2 Tabelle auf Monatsbasis. Um Änderungen der Einkaufspreise durch Rückbewertungen verfolgen zu können soll hier ein monatlicher Abzug der Einkaufspreise aus den Tabellen art_gp_wup_zu_per_2 und art_umsatz_kmep_zu_per_2 eingefügt werden.';
