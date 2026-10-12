CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_VW_SUM (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,dat                                      COMMENT 'Datum des Reklamationsvorgangs.'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'
  ,gp_id                                    COMMENT 'Geschäftspartner-ID (auch Lieferanten-ID).'
  ,art_id                                   COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'
  ,vw_id                                    COMMENT 'ID des Vertriebsweges.'
  ,bezugsweg_id                             COMMENT 'Bezugsweg der Ware (direkt vom Lieferanen = 1 oder über Zentrallager = 4).'
  ,wup_bereinigt_fg                         COMMENT 'Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'
  ,menge                                    COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein).'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag.'
  ,umsatz_mwst_betrag                       COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'
  ,ek_mep                                   COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'
  ,ek_mep_vor_fwu                           COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'
  ,ek_mep_vor_fwu_konz                      COMMENT 'Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'
  ,einstandspreis                           COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'
  ,ek_nettonetto                            COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs '
  ,diff_einstandspreis_konz                 COMMENT 'Von der Konzernwährung abweichender Einstandspreis.'
  ,diff_ek_brutto_konz                      COMMENT 'Von der Konzernwährung abweichender Einkaufspreis brutto.'
  ,diff_ek_gld_konz                         COMMENT 'Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'
  ,diff_ek_kal_basis_konz                   COMMENT 'Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'
  ,diff_ek_mep_konz                         COMMENT 'Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'
  ,diff_ek_netto_bnk_konz                   COMMENT 'Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'
  ,diff_ek_netto_bnk_sachk_konz             COMMENT 'Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'
  ,diff_ek_netto_konz                       COMMENT 'Von der Konzernwährung abweichender Einkaufspreis netto.'
  ,diff_ek_nettonetto_konz                  COMMENT 'Von der Konzernwährung abweichender Einkaufspreis nettonetto.'
  ,diff_logkostenzuschlag_konz              COMMENT 'Von der Konzernwährung abweichender Logistikkostenzuschlag.'
  ,diff_umsatz_mwst_betrag_konz             COMMENT 'Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'
  ,diff_umsatz_netto_konz                   COMMENT 'Von der Konzernwährung abweichender Umsatz netto.'
  ,ean_kasse                                COMMENT 'Von den Kassensystemen gelieferte EAN / GTIN.'
  ,ek_brutto                                COMMENT 'Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'
  ,ek_gld                                   COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'
  ,ek_kal_basis                             COMMENT 'Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'
  ,ek_netto                                 COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'
  ,ek_netto_bnk                             COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'
  ,ek_netto_bnk_sachk                       COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'
  ,herst_id                                 COMMENT 'Der Hersteller des Artikels (kann abweichend zum Lieferanten sein).'
  ,logkostenzuschlag                        COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'
  ,bonusbasis                               COMMENT 'Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'
  ,bonusbasis_konz                          COMMENT 'Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'
  ,bewart_det_id                            COMMENT 'Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'
  ,pv_aktion                                COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'
  ,pv_aktion_konz                           COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion zustande gekommen ist.'
  ,pv_bby                                   COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'
  ,pv_bby_konz                              COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Standard BBY zustande gekommen ist.'
  ,pv_kdn_bby                               COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'
  ,pv_kdn_bby_konz                          COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'
  ,pv_kdp_bby                               COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'
  ,pv_kdp_bby_konz                          COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'
  ,pv_aktion_bby                            COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_bby_konz                       COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdn_bby                        COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdn_bby_konz                   COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdp_bby                        COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'
  ,pv_aktion_kdp_bby_konz                   COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine Aktion in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'
  ,pv_bonrabatt_bby                         COMMENT 'Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'
  ,pv_bonrabatt_bby_konz                    COMMENT 'Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'
)
COMMENT = 'TP2 AIS - Aggregat Artbew auf der Ebene Artikel/Tag/Vertriebsweg'
 AS 
    SELECT 
        mandant_id,
        dat,
        bewart_id,
        gp_id,
        art_id,
        vw_id,
        bezugsweg_id,
        wup_bereinigt_fg,
        menge,
        umsatz_netto,
        umsatz_mwst_betrag,
        ek_mep,
        ek_mep_vor_fwu,
        ek_mep_vor_fwu_konz,
        einstandspreis,
        ek_nettonetto,
        wrg_id,
        umrechnungskurs_hist,
        diff_einstandspreis_konz,
        diff_ek_brutto_konz,
        diff_ek_gld_konz,
        diff_ek_kal_basis_konz,
        diff_ek_mep_konz,
        diff_ek_netto_bnk_konz,
        diff_ek_netto_bnk_sachk_konz,
        diff_ek_netto_konz,
        diff_ek_nettonetto_konz,
        diff_logkostenzuschlag_konz,
        diff_umsatz_mwst_betrag_konz,
        diff_umsatz_netto_konz,
        ean_kasse,
        ek_brutto,
        ek_gld,
        ek_kal_basis,
        ek_netto,
        ek_netto_bnk,
        ek_netto_bnk_sachk,
        herst_id,
        logkostenzuschlag,
        bonusbasis,
        bonusbasis_konz,
        bewart_det_id,
        pv_aktion,
        pv_aktion_konz,
        pv_bby,
        pv_bby_konz,
        pv_kdn_bby,
        pv_kdn_bby_konz,
        pv_kdp_bby,
        pv_kdp_bby_konz,
        pv_aktion_bby,
        pv_aktion_bby_konz,
        pv_aktion_kdn_bby,
        pv_aktion_kdn_bby_konz,
        pv_aktion_kdp_bby,
        pv_aktion_kdp_bby_konz,
        pv_bonrabatt_bby,
        pv_bonrabatt_bby_konz

FROM DBP_DATA.ARTBEW_VW_SUM ;