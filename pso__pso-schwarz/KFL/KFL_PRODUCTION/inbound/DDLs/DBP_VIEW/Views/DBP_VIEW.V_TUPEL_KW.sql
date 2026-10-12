CREATE OR REPLACE VIEW DBP_VIEW.V_TUPEL_KW (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,kjwo                                     COMMENT 'Kalenderjahreswoche. Format JJJJWW'
  ,matching_id                              COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,anzahl_markt_wochen_kombis_abverkauf_af  COMMENT 'Zählung der Markt-Tag Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_sa  COMMENT 'Zählung der Markt-Tag Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_af_vj COMMENT 'Zählung der Markt-Tag Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_sa_vj COMMENT 'Zählung der Markt-Tag Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,kassenumsatz_kl_absolut_brutto           COMMENT 'Kassenumsatz Kaufland brutto'
  ,kassenumsatz_af_kl_absolut_brutto        COMMENT 'Kassenumsatz Kaufland brutto AF'
  ,kassenumsatz_sa_kl_absolut_brutto        COMMENT 'Kassenumsatz Kaufland brutto SA'
  ,kassenumsatz_kl_absolut_brutto_vj        COMMENT 'Kassenumsatz Kaufland brutto'
  ,kassenumsatz_af_kl_absolut_brutto_vj     COMMENT 'Kassenumsatz Kaufland brutto AF VJ'
  ,kassenumsatz_sa_kl_absolut_brutto_vj     COMMENT 'Kassenumsatz Kaufland brutto SA VJ'
  ,kassenumsatz_kl_absolut_netto            COMMENT 'Kassenumsatz Kaufland netto'
  ,kassenumsatz_af_kl_absolut_netto         COMMENT 'Kassenumsatz Kaufland netto AF'
  ,kassenumsatz_sa_kl_absolut_netto         COMMENT 'Kassenumsatz Kaufland netto SA'
  ,kassenumsatz_kl_absolut_netto_vj         COMMENT 'Kassenumsatz Kaufland netto VJ'
  ,kassenumsatz_af_kl_absolut_netto_vj      COMMENT 'Kassenumsatz Kaufland netto AF VJ'
  ,kassenumsatz_sa_kl_absolut_netto_vj      COMMENT 'Kassenumsatz Kaufland netto SA VJ'
  ,absatz_kl                                COMMENT 'Gesamtabsatz'
  ,absatz_af_kl                             COMMENT 'Gesamtabsatz AF'
  ,absatz_sa_kl                             COMMENT 'Gesamtabsatz SA'
  ,absatz_kl_vj                             COMMENT 'Gesamtabsatz VJ'
  ,absatz_af_kl_vj                          COMMENT 'Gesamtabsatz AF VJ'
  ,absatz_sa_kl_vj                          COMMENT 'Gesamtabsatz SA VJ'
  ,absatz_sst1                              COMMENT 'Absatz sst1'
  ,absatz_sst2                              COMMENT 'Absatz sst2'
  ,absatz_sst3                              COMMENT 'Absatz sst3'
  ,absatz_sst4                              COMMENT 'Absatz sst4'
  ,absatz_sst5                              COMMENT 'Absatz sst5'
  ,absatz_sst6                              COMMENT 'Absatz sst6'
  ,absatz_sst7                              COMMENT 'Absatz sst7'
  ,absatz_ksst1                             COMMENT 'Absatz ksst1'
  ,absatz_ksst2                             COMMENT 'Absatz ksst2'
  ,absatz_ksst3                             COMMENT 'Absatz ksst3'
  ,absatz_ksst4                             COMMENT 'Absatz ksst4'
  ,absatz_ksst5                             COMMENT 'Absatz ksst5'
  ,absatz_ksst6                             COMMENT 'Absatz ksst6'
  ,absatz_ksst7                             COMMENT 'Absatz ksst7'
  ,absatz_ost_basis                         COMMENT 'Absatz Ost Basis'
  ,absatz_ost_gross                         COMMENT 'Absatz Ost groß'
  ,absatz_sued_ost                          COMMENT 'Absatz Süd-Ost'
  ,absatz_sued_west                         COMMENT 'Absatz Süd-West'
  ,absatz_west                              COMMENT 'Absatz West'
  ,absatz_nord                              COMMENT 'Absatz Nord'
  ,markt_wochen_sst1                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst1'
  ,markt_wochen_sst2                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst2'
  ,markt_wochen_sst3                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst3'
  ,markt_wochen_sst4                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst4'
  ,markt_wochen_sst5                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst5'
  ,markt_wochen_sst6                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst6'
  ,markt_wochen_sst7                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf sst7'
  ,markt_wochen_ksst1                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst1'
  ,markt_wochen_ksst2                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst2'
  ,markt_wochen_ksst3                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst3'
  ,markt_wochen_ksst4                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst4'
  ,markt_wochen_ksst5                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst5'
  ,markt_wochen_ksst6                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst6'
  ,markt_wochen_ksst7                       COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf ksst7'
  ,markt_wochen_ost_basis                   COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf Ost Basis'
  ,markt_wochen_ost_gross                   COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf Ost groß'
  ,markt_wochen_sued_ost                    COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf Süd-Ost'
  ,markt_wochen_sued_west                   COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf Süd-West'
  ,markt_wochen_west                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf West'
  ,markt_wochen_nord                        COMMENT 'Zählung der Markt-Wochen Kombinationen Abverkauf Nord'
  ,anzahl_markt_wochen_kombis_abverkauf_mit_listung COMMENT 'Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag von Mo-Sa eine Listung gab'
  ,anzahl_markt_wochen_kombis_listung       COMMENT 'Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag von Mo-Sa eine Listung gab'
  ,rohertrag_ekmep_olk_4n                   COMMENT 'Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,anz_bons_af                              COMMENT 'Zähler für: Bonreichweite aktionsfreie Ware aus Shopper (Verteilung über verschiedene WG hinweg)'
  ,anz_bons_sa                              COMMENT 'Zähler für: Bonreichweite Sonderaktionsware aus Shopper (Verteilung über verschiedene WG hinweg)'
  ,anz_bons_gesamt                          COMMENT 'Nenner für: Bonreichweite AF und SA'
  ,rohertrag_ekmep_olk_4n_vj                COMMENT 'Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_af                COMMENT 'Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_sa                COMMENT 'Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_af_vj             COMMENT 'hertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_sa_vj             COMMENT 'Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'
  ,totalabschriften_wert_netto_absolut      COMMENT 'Abschriftensumme VK netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften'
  ,preisabschriften_preisanderungen_wert_netto_absolut COMMENT 'Abschriften VK netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'
  ,totalabschriften_wert_netto_absolut_vj   COMMENT 'Abschriftensumme VK netto VJ, nur Totalabschriften (Definition offen)'
  ,preisabschriften_preisanderungen_wert_netto_absolut_vj COMMENT 'Abschriften VK netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'
  ,totalabschriften_wert_netto_absolut_wg   COMMENT 'Abschriftensumme VK netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'
  ,preisabschriften_preisanderungen_wert_netto_absolut_wg COMMENT 'Abschriften VK netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'
  ,anz_bons_af_markt_tag                    COMMENT 'Anzahl Bons, die an dem gesamten Markt-Tag produziert sind und auf denen der aktionsfreie (AF) Artikel, verkauft wurde.'
  ,anz_bons_sa_markt_tag                    COMMENT 'Anzahl Bons, die an dem gesamten Markt-Tag produziert sind und auf denen der in Sonderaktion (SA) Artikel, verkauft wurde.'
  ,cpq_tupel                                COMMENT 'Cherrypicker Quote aus Shopper'
  ,cp_bons_af                               COMMENT 'Cherrpicker Bons AF auf denen der Artikel verkauft wurde '
  ,cp_bons_sa                               COMMENT 'Cherrpicker Bons SA auf denen der Artikel verkauft wurde '
  ,kassenumsatz_kl_absolut_netto_wg         COMMENT 'Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'
  ,anz_bons_tupel                           COMMENT 'Anzahl Bons, auf denen der Artikel enthalten ist (AF+SA). Nenner für Restbon'
  ,restbon_summe                            COMMENT 'Summe Kassenumsatz netto aller Bons aller Artikel des Tupels. Zähler für Restbon'
  ,absatz_af_kl_listungswochen              COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,absatz_af_kl_vj_listungswochen           COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,absatz_sa_kl_listungswochen              COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,absatz_sa_kl_vj_listungswochen           COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,kassenumsatz_af_kl_absolut_netto_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,kassenumsatz_af_kl_absolut_netto_vj_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,kassenumsatz_sa_kl_absolut_netto_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_af_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_af_vj_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_sa_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_sa_vj_listungswochen COMMENT 'Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'
)
COMMENT = 'EK_SORT - Aggregat - Teilmenge von tupel_mat auf Ebene KW.'
 AS 
    SELECT 
        mandant_id,
        kjwo,
        matching_id,
        wrg_id,
        anzahl_markt_wochen_kombis_abverkauf_af,
        anzahl_markt_wochen_kombis_abverkauf_sa,
        anzahl_markt_wochen_kombis_abverkauf_af_vj,
        anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        kassenumsatz_kl_absolut_brutto,
        kassenumsatz_af_kl_absolut_brutto,
        kassenumsatz_sa_kl_absolut_brutto,
        kassenumsatz_kl_absolut_brutto_vj,
        kassenumsatz_af_kl_absolut_brutto_vj,
        kassenumsatz_sa_kl_absolut_brutto_vj,
        kassenumsatz_kl_absolut_netto,
        kassenumsatz_af_kl_absolut_netto,
        kassenumsatz_sa_kl_absolut_netto,
        kassenumsatz_kl_absolut_netto_vj,
        kassenumsatz_af_kl_absolut_netto_vj,
        kassenumsatz_sa_kl_absolut_netto_vj,
        absatz_kl,
        absatz_af_kl,
        absatz_sa_kl,
        absatz_kl_vj,
        absatz_af_kl_vj,
        absatz_sa_kl_vj,
        absatz_sst1,
        absatz_sst2,
        absatz_sst3,
        absatz_sst4,
        absatz_sst5,
        absatz_sst6,
        absatz_sst7,
        absatz_ksst1,
        absatz_ksst2,
        absatz_ksst3,
        absatz_ksst4,
        absatz_ksst5,
        absatz_ksst6,
        absatz_ksst7,
        absatz_ost_basis,
        absatz_ost_gross,
        absatz_sued_ost,
        absatz_sued_west,
        absatz_west,
        absatz_nord,
        markt_wochen_sst1,
        markt_wochen_sst2,
        markt_wochen_sst3,
        markt_wochen_sst4,
        markt_wochen_sst5,
        markt_wochen_sst6,
        markt_wochen_sst7,
        markt_wochen_ksst1,
        markt_wochen_ksst2,
        markt_wochen_ksst3,
        markt_wochen_ksst4,
        markt_wochen_ksst5,
        markt_wochen_ksst6,
        markt_wochen_ksst7,
        markt_wochen_ost_basis,
        markt_wochen_ost_gross,
        markt_wochen_sued_ost,
        markt_wochen_sued_west,
        markt_wochen_west,
        markt_wochen_nord,
        anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        anzahl_markt_wochen_kombis_listung,
        rohertrag_ekmep_olk_4n,
        anz_bons_af,
        anz_bons_sa,
        anz_bons_gesamt,
        rohertrag_ekmep_olk_4n_vj,
        rohertrag_ekmep_olk_4n_af,
        rohertrag_ekmep_olk_4n_sa,
        rohertrag_ekmep_olk_4n_af_vj,
        rohertrag_ekmep_olk_4n_sa_vj,
        totalabschriften_wert_netto_absolut,
        preisabschriften_preisanderungen_wert_netto_absolut,
        totalabschriften_wert_netto_absolut_vj,
        preisabschriften_preisanderungen_wert_netto_absolut_vj,
        totalabschriften_wert_netto_absolut_wg,
        preisabschriften_preisanderungen_wert_netto_absolut_wg,
        anz_bons_af_markt_tag,
        anz_bons_sa_markt_tag,
        cpq_tupel,
        cp_bons_af,
        cp_bons_sa,
        kassenumsatz_kl_absolut_netto_wg,
        anz_bons_tupel,
        restbon_summe,
        absatz_af_kl_listungswochen,
        absatz_af_kl_vj_listungswochen,
        absatz_sa_kl_listungswochen,
        absatz_sa_kl_vj_listungswochen,
        kassenumsatz_af_kl_absolut_netto_listungswochen,
        kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        kassenumsatz_sa_kl_absolut_netto_listungswochen,
        kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        rohertrag_ekmep_olk_4n_af_listungswochen,
        rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        rohertrag_ekmep_olk_4n_sa_listungswochen,
        rohertrag_ekmep_olk_4n_sa_vj_listungswochen

FROM DBP_DATA.TUPEL_KW ;