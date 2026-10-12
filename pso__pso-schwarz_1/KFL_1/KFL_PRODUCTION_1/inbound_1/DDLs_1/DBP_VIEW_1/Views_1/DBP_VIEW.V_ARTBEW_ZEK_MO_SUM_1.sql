CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_ZEK_MO_SUM_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,wup_id                                   COMMENT 'Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,kjmo                                     COMMENT 'Kalenderjahresmonat.'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'
  ,bewart_det_id                            COMMENT 'Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id.'
  ,posten_id                                COMMENT 'Postenkennzeichen. Für Artikel_1, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'
  ,zek_id                                   COMMENT 'Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch. So gesehen eine_1 überflüssige ID (?).'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 '
  ,menge                                    COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_1 reduziert um zurückgegebene Artikel.'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag.'
  ,diff_umsatz_netto_konz                   COMMENT 'Von der Konzernwährung abweichender Umsatz netto.'
  ,umsatz_mwst_betrag                       COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_1 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'
  ,diff_umsatz_mwst_betrag_konz             COMMENT 'Von der Konzernwährung abweichender Mehrwertsteuerbetrag.'
  ,ek_brutto                                COMMENT 'Einkaufspreis brutto (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_brutto_konz                      COMMENT 'Von der Konzernwährung abweichender Einkaufspreis brutto.'
  ,ek_netto                                 COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_netto_konz                       COMMENT 'Von der Konzernwährung abweichender Einkaufspreis netto.'
  ,ek_nettonetto                            COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_nettonetto_konz                  COMMENT 'Von der Konzernwährung abweichender Einkaufspreis nettonetto.'
  ,ek_kal_basis                             COMMENT 'Kalkulationsbasis (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_kal_basis_konz                   COMMENT 'Von der Konzernwährung abweichender Einkaufspreis Kalkulationsbasis.'
  ,ek_mep                                   COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_mep_konz                         COMMENT 'Von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis.'
  ,ek_mep_vor_fwu                           COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'
  ,ek_mep_vor_fwu_konz                      COMMENT 'Markteinstandspreis vor Festwertumlage in Konzernwährung, wenn Landeswährung davon abweicht. Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'
  ,einstandspreis                           COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'
  ,diff_einstandspreis_konz                 COMMENT 'Von der Konzernwährung abweichender Einstandspreis.'
  ,logkostenzuschlag                        COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'
  ,diff_logkostenzuschlag_konz              COMMENT 'Von der Konzernwährung abweichender Logistikkostenzuschlag.'
  ,ek_netto_bnk                             COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_netto_bnk_konz                   COMMENT 'Differenz des Einkaufspreis netto plus Bezugsnebenkosten zur Konzernwährung.'
  ,ek_netto_bnk_sachk                       COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten (Bedeutung vgl. Kalkulationsschema).'
  ,diff_ek_netto_bnk_sachk_konz             COMMENT 'Differenz des Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten zur Konzernwährung.'
  ,ek_gld                                   COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'
  ,diff_ek_gld_konz                         COMMENT 'Differenz zum gleitenden Durchschnittspreis in Konzernwährung.'
  ,bonusbasis                               COMMENT 'Die Bonusbasis bildet für Artikel_1 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'
  ,bonusbasis_konz                          COMMENT 'Bonusbasis in Konzernwährung, wenn Landeswährung davon abweicht. Die Bonusbasis bildet für Artikel_1 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA.'
  ,pv_aktion                                COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 zustande gekommen ist.'
  ,pv_aktion_konz                           COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 zustande gekommen ist.'
  ,pv_bby                                   COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Standard BBY zustande gekommen ist.'
  ,pv_bby_konz                              COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Standard BBY zustande gekommen ist.'
  ,pv_kdn_bby                               COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'
  ,pv_kdn_bby_konz                          COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDN Kundenkarten BBY zustande gekommen ist.'
  ,pv_kdp_bby                               COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'
  ,pv_kdp_bby_konz                          COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch einen KDP Kundenkarte BBY zustande gekommen ist.'
  ,pv_aktion_bby                            COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_bby_konz                       COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdn_bby                        COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdn_bby_konz                   COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem Standard BBY zustande gekommen ist. PV Differenz BBY-Preis zu Aktionspreis fließt in pv_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_bby.'
  ,pv_aktion_kdp_bby                        COMMENT 'PV-Kennzahlen werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'
  ,pv_aktion_kdp_bby_konz                   COMMENT 'PV-Kennzahlen in Konzernwährung werden auf Bondatenebene berechnet und im Anschluss daran aggregiert hier eingefügt. PV wenn Abverkauf durch eine_1 Aktion_1 in Kombination mit einem KD Kundenkarten BBY zustande gekommen ist. PV Differenz KDP-BBY-Preis zu Aktionspreis fließt in pv_kdp_bby. PV Differenz Aktionspreis zu Normalpreis fließt in pv_aktion_kdp_bby.'
  ,pv_bonrabatt_bby                         COMMENT 'Feld beinhaltet die PVs die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_1 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_1 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_1 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_1 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_1 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'
  ,pv_bonrabatt_bby_konz                    COMMENT 'Feld beinhaltet die PVs in Konzernwährung die nur durch die Bonrabatte erzeugt werden. Ein Bonrabatt ist ein Rabatt bei dem ein Kunde ab einem bestimmten Gesamteinkaufswert einen Betrag von der Rechnung abgezogen bekommt (z.B. 10€ Rabatt ab einem Gesamteinkaufswert von 100€). Dieser Wert wird im Bon anteilig von allen Produkten abgezogen. Ein Artikel_1 mit einem Bonrabattwert gilt trotzdem als aktionsfrei wenn er ansonsten in keiner Aktion_1 ist. Bonrabatte stehen in der Tabelle DBP_ODS.ODS_PROMOTION_1 und haben die KONDITIONSART_IDs ZBON oder ZBOV. Für die Bestimmung der Art_1 des BBYs (KDN, KDP, Standard) verwendet man die Flags CUSTOMER_PROMOTION_FG und PROMOTION_ART in DBP_ODS.ODS_PROMOTION. Eine_1 Differenzierung für Bonrabatt BBY ist NICHT notwendig laut Fachbereich, stand 01.12.2022.'
)
COMMENT = 'TP2 AIS - Aggregat Artbew_1 auf der Ebene ZEK_1/Monat_1/Markt - Multiset'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        kjmo,
        bewart_id,
        bewart_det_id,
        posten_id,
        zek_id,
        wrg_id,
        umrechnungskurs_hist,
        menge,
        umsatz_netto,
        diff_umsatz_netto_konz,
        umsatz_mwst_betrag,
        diff_umsatz_mwst_betrag_konz,
        ek_brutto,
        diff_ek_brutto_konz,
        ek_netto,
        diff_ek_netto_konz,
        ek_nettonetto,
        diff_ek_nettonetto_konz,
        ek_kal_basis,
        diff_ek_kal_basis_konz,
        ek_mep,
        diff_ek_mep_konz,
        ek_mep_vor_fwu,
        ek_mep_vor_fwu_konz,
        einstandspreis,
        diff_einstandspreis_konz,
        logkostenzuschlag,
        diff_logkostenzuschlag_konz,
        ek_netto_bnk,
        diff_ek_netto_bnk_konz,
        ek_netto_bnk_sachk,
        diff_ek_netto_bnk_sachk_konz,
        ek_gld,
        diff_ek_gld_konz,
        bonusbasis,
        bonusbasis_konz,
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

FROM DBP_DATA.ARTBEW_ZEK_MO_SUM_1 ;