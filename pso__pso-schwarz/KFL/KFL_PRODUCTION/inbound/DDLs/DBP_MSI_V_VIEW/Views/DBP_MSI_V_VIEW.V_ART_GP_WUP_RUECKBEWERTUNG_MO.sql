CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_ART_GP_WUP_RUECKBEWERTUNG_MO (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kjmo                                     COMMENT 'Monat eines Kalenderjahre im Format JJJJMM.'
  ,art_id                                   COMMENT 'Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)'
  ,wup_id                                   COMMENT 'Warenumschlagplatz. Hier die Marktnummer für den die Einkaufspreise gelten.'
  ,nb_id                                    COMMENT 'Nebenbetriebs ID. Kennzeichnet den Typ des Marktes (WUP).'
  ,dat_gueltig_von                          COMMENT 'Beginn der Gültigkeitsperiode in der die EK-Preise für einen Artikel von einem Lieferanten in einer Filiale gültig sind.'
  ,dat_gueltig_bis                          COMMENT 'Ende der Gültigkeitsperiode in der die EK-Preise für einen Artikel von einem Lieferanten in einer Filiale gültig sind.'
  ,dat_abzug                                COMMENT 'Datum, an dem der Datensatz extrahiert und in die Tabelle hinzugefügt wurde.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR'
  ,preis_ek_mep                             COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema), aus MEPRE.'
  ,preis_ek_mep_vor_fwu                     COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt. Quellfeld in SAP: ZEKP.MEPOL'
  ,preis_ek_netto_bnk                       COMMENT 'Einkaufspreis netto zuzüglich Bezugsnebenkosten, aus AKBN. Verwendet den Aktionspreis, wenn vorhanden, ansonsten den Normalpreis.'
  ,preis_ek_einstandspreis                  COMMENT 'Einstandspreis (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Ergibt sich aus dem Einkaufspreis netto einer Ware zuzüglich der Beschaffungskosten oder Bezugskosten und abzüglich der Minderungen, etwa durch Rabatt, Skonto, Bonus. Unterster EK im Kalkulationsschema, darf im VK nicht unterschritten werden.'
  ,preis_ek_nettonetto                      COMMENT 'EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto aus AKNNE..'
  ,preis_kmep_einh_o_fwu                    COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'
)
COMMENT = 'Bei der Tabelle handelt es sich um eine periodic Snapshot Tabelle auf Monatsbasis. Um Änderungen der Einkaufspreise durch Rückbewertungen verfolgen zu können soll hier ein monatlicher Abzug der Einkaufspreise aus den Tabellen art_gp_wup_zu_per und art_umsatz_kmep_zu_per eingefügt werden.'
 AS 
    SELECT 
        mandant_id,
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

FROM DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO ;