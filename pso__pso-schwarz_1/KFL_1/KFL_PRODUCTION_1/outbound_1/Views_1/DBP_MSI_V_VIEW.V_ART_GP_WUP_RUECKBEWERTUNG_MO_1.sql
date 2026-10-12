CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_art_gp_wup_rueckbewertung_mo_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), kjmo OPTIONS(description='Monat_1 eines Kalenderjahre im Format JJJJMM.'), art_id
OPTIONS(description='Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), wup_id
OPTIONS(description='Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.'), nb_id
OPTIONS(description='Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP_1).'), dat_gueltig_von
OPTIONS(description='Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel_1 von einem Lieferanten in einer Filiale gültig sind.'),
dat_gueltig_bis
OPTIONS(description='Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel_1 von einem Lieferanten in einer Filiale gültig sind.'),
dat_abzug OPTIONS(description='Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), preis_ek_mep
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.'), preis_ek_mep_vor_fwu
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL'),
preis_ek_netto_bnk
OPTIONS(description='Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'),
preis_ek_einstandspreis
OPTIONS(description='Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK_1 nicht unterschritten werden.'),
preis_ek_nettonetto OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..'),
preis_kmep_einh_o_fwu
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'))
OPTIONS(DESCRIPTION = `BEI DER TABELLE HANDELT ES SICH UM EINE_1 PERIODIC SNAPSHOT_1 TABELLE AUF MONATSBASIS. UM ÄNDERUNGEN DER EINKAUFSPREISE DURCH RÜCKBEWERTUNGEN VERFOLGEN ZU KÖNNEN SOLL HIER EIN MONATLICHER ABZUG DER EINKAUFSPREISE AUS DEN TABELLEN ART_GP_WUP_ZU_PER_1 UND ART_UMSATZ_KMEP_ZU_PER_1 EINGEFÜGT WERDEN.`)
AS SELECT mandant_id,
 kjmo,
 art_id,
 gp_id,
 wup_id,
 nb_id,
 dat_gueltig_von,
 dat_gueltig_bis,
 dat_abzug,
 wrg_id,
 preis_ek_mep,
 preis_ek_mep_vor_fwu,
 preis_ek_netto_bnk,
 preis_ek_einstandspreis,
 preis_ek_nettonetto,
 preis_kmep_einh_o_fwu
FROM kfl_production_dbp_msi_data.art_gp_wup_rueckbewertung_mo_1;