CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TUPEL_MAT_QUARANTAENE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,a500_kjwo_update                         COMMENT 'Kalenderjahreswoche. Format JJJJWW'
  ,matching_id                              COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'
  ,a425_kjmo                                COMMENT 'Monat_1 eines Kalenderjahres, Format JJJJMM'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,a5_owg_id                                COMMENT 'ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'
  ,a7_wg_id                                 COMMENT 'ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'
  ,wug_id                                   COMMENT 'ID der Warenuntergruppe'
  ,art_id                                   COMMENT 'Führende Artikelnummer: Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'
  ,kl_art_id                                COMMENT '7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'
  ,a450_art_nielsen_nr                      COMMENT 'Artikelnummer bei Nielsen'
  ,art_bez_deutsch                          COMMENT 'Artikelbezeichnung deutsch spr_id 22'
  ,a14_art_status_de                        COMMENT 'Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'
  ,nielsen_art_bez                          COMMENT 'Liste an Artikelbezeichnungen aus Nielsen.'
  ,nielsen_gtin                             COMMENT 'Global Trade Item_1 Number (GTIN)'
  ,a58_rang_umsatz_owg                      COMMENT 'Rang matching_id innerhalb OWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'
  ,a2_rang_umsatz_wg                        COMMENT 'Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'
  ,a59_rang_absatz_wg                       COMMENT 'Rang matching_id innerhalb WG auf Basis Absatz (wird im ETL-Prozess ermittelt)'
  ,a16_akt_lieferant_id                     COMMENT 'Aktueller Lieferant (gp_id) aus art_gp_zu_per_1 mit dat_bis 31.12.9999'
  ,a419_hersteller_id                       COMMENT 'Nur DE: Wenn Hersteller von Lieferant abweicht wird hersteller_id abweichend von gp_id angezeigt, ansonsten leer.'
  ,a446_lieferant_bez_latein                COMMENT 'Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'
  ,a447_hersteller_bez_latein               COMMENT 'Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'
  ,lieferant_nielsen                        COMMENT 'Liste an Lieferantennamen aus Nielsen.'
  ,a389_zek_id                              COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'
  ,a391_disc_pe                             COMMENT 'Discount Kennzeichen PE (Herkunft noch klären!)'
  ,a392_disc_ohne_etikett                   COMMENT 'Discount Kennzeichen Marke (artkz_discount_1)'
  ,a400_lcf                                 COMMENT 'lactose_fg aus Tabelle art_1'
  ,a393_vegan                               COMMENT 'vegan_fg aus Tabelle art_1'
  ,a394_gluten                              COMMENT 'gluten_fg aus Tabelle art_1'
  ,a395_bio                                 COMMENT 'bio_fg aus Tabelle art_1'
  ,a396_eigenmarke                          COMMENT 'eigenmarke_fg_kl aus Tabelle art_1'
  ,a397_tierwohl                            COMMENT 'tierwohl_fg aus Tabelle art_1'
  ,a398_posten_food                         COMMENT 'Flag Posten Food (abgeleitet aus artkz_posten_1)'
  ,a399_posten_nonfood                      COMMENT 'Flag Posten NonFood (abgeleitet aus artkz_posten_1)'
  ,a339_umsatzsteuer                        COMMENT 'Mehrwertsteuersatz'
  ,a60_muki_vk_kz                           COMMENT 'Zeigt mit W/M/K an, ob und wie Artikel_1 der Matching ID in VK_1-Muki sind'
  ,a61_muki_vk_kl_art_id_verkettung         COMMENT 'Liste alle VK_1-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'
  ,anzahl_markt_wochen_kombis_abverkauf_af  COMMENT 'Zählung der Markt-Tag_1 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_sa  COMMENT 'Zählung der Markt-Tag_1 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_af_vj COMMENT 'Zählung der Markt-Tag_1 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,anzahl_markt_wochen_kombis_abverkauf_sa_vj COMMENT 'Zählung der Markt-Tag_1 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'
  ,a273_kassenumsatz_kl_absolut_brutto      COMMENT 'Kassenumsatz Kaufland brutto'
  ,kassenumsatz_af_kl_absolut_brutto        COMMENT 'Kassenumsatz Kaufland brutto AF'
  ,kassenumsatz_sa_kl_absolut_brutto        COMMENT 'Kassenumsatz Kaufland brutto SA'
  ,kassenumsatz_kl_absolut_brutto_vj        COMMENT 'Kassenumsatz Kaufland brutto'
  ,kassenumsatz_af_kl_absolut_brutto_vj     COMMENT 'Kassenumsatz Kaufland brutto AF VJ'
  ,kassenumsatz_sa_kl_absolut_brutto_vj     COMMENT 'Kassenumsatz Kaufland brutto SA VJ'
  ,a21_kassenumsatz_kl_absolut_netto        COMMENT 'Kassenumsatz Kaufland netto'
  ,kassenumsatz_af_kl_absolut_netto         COMMENT 'Kassenumsatz Kaufland netto AF'
  ,kassenumsatz_sa_kl_absolut_netto         COMMENT 'Kassenumsatz Kaufland netto SA'
  ,kassenumsatz_kl_absolut_netto_vj         COMMENT 'Kassenumsatz Kaufland netto VJ'
  ,kassenumsatz_af_kl_absolut_netto_vj      COMMENT 'Kassenumsatz Kaufland netto AF VJ'
  ,kassenumsatz_sa_kl_absolut_netto_vj      COMMENT 'Kassenumsatz Kaufland netto SA VJ'
  ,a17_absatz_kl                            COMMENT 'Gesamtabsatz'
  ,absatz_af_kl                             COMMENT 'Gesamtabsatz AF'
  ,absatz_sa_kl                             COMMENT 'Gesamtabsatz SA'
  ,absatz_kl_vj                             COMMENT 'Gesamtabsatz VJ'
  ,absatz_af_kl_vj                          COMMENT 'Gesamtabsatz AF VJ'
  ,absatz_sa_kl_vj                          COMMENT 'Gesamtabsatz SA VJ'
  ,a76_absatz_sst1                          COMMENT 'Absatz sst1'
  ,a78_absatz_sst2                          COMMENT 'Absatz sst2'
  ,a80_absatz_sst3                          COMMENT 'Absatz sst3'
  ,a82_absatz_sst4                          COMMENT 'Absatz sst4'
  ,a84_absatz_sst5                          COMMENT 'Absatz sst5'
  ,a86_absatz_sst6                          COMMENT 'Absatz sst6'
  ,a88_absatz_sst7                          COMMENT 'Absatz sst7'
  ,a62_absatz_ksst1                         COMMENT 'Absatz ksst1'
  ,a64_absatz_ksst2                         COMMENT 'Absatz ksst2'
  ,a66_absatz_ksst3                         COMMENT 'Absatz ksst3'
  ,a68_absatz_ksst4                         COMMENT 'Absatz ksst4'
  ,a70_absatz_ksst5                         COMMENT 'Absatz ksst5'
  ,a72_absatz_ksst6                         COMMENT 'Absatz ksst6'
  ,a74_absatz_ksst7                         COMMENT 'Absatz ksst7'
  ,a90_absatz_ost_basis                     COMMENT 'Absatz Ost Basis'
  ,a92_absatz_ost_gross                     COMMENT 'Absatz Ost groß'
  ,a94_absatz_sued_ost                      COMMENT 'Absatz Süd-Ost'
  ,a96_absatz_sued_west                     COMMENT 'Absatz Süd-West'
  ,a98_absatz_west                          COMMENT 'Absatz West'
  ,a100_absatz_nord                         COMMENT 'Absatz Nord'
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
  ,anzahl_markt_wochen_kombis_abverkauf_mit_listung COMMENT 'Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'
  ,anzahl_markt_wochen_kombis_listung       COMMENT 'Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'
  ,a31_vk_brutto_kl_pk_1                    COMMENT 'VK_1 Preis  brutto PM_1-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per_1'
  ,a333_vk_brutto_kl_pk_2                   COMMENT 'VK_1 Preis  brutto PM_1-ID 2 (Preiskategorie 2) aus Tabelle art_pm_vw_zu_per_1'
  ,a54_vk_brutto_kl_pk_3                    COMMENT 'VK_1 Preis  brutto PM_1-ID 3 (Preiskategorie 3) aus Tabelle art_pm_vw_zu_per_1'
  ,a334_vk_brutto_kl_pk_4                   COMMENT 'VK_1 Preis  brutto PM_1-ID 4 (Preiskategorie 4) aus Tabelle art_pm_vw_zu_per_1'
  ,a432_vk_brutto_kl_pk_5                   COMMENT 'VK_1 Preis  brutto PM_1-ID 5 (Preiskategorie 5) aus Tabelle art_pm_vw_zu_per_1'
  ,a433_vk_brutto_kl_pk_6                   COMMENT 'VK_1 Preis  brutto PM_1-ID 6 (Preiskategorie 6) aus Tabelle art_pm_vw_zu_per_1'
  ,a434_vk_brutto_kl_pk_7                   COMMENT 'VK_1 Preis  brutto PM_1-ID 7 (Preiskategorie 7) aus Tabelle art_pm_vw_zu_per_1'
  ,a435_vk_brutto_kl_pk_8                   COMMENT 'VK_1 Preis  brutto PM_1-ID 8 (Preiskategorie 8) aus Tabelle art_pm_vw_zu_per_1'
  ,a436_vk_brutto_kl_pk_9                   COMMENT 'VK_1 Preis  brutto PM_1-ID 9 (Preiskategorie 9) aus Tabelle art_pm_vw_zu_per_1'
  ,a437_vk_brutto_kl_pk_10                  COMMENT 'VK_1 Preis  brutto PM_1-ID 10 (Preiskategorie 10) aus Tabelle art_pm_vw_zu_per_1'
  ,a30_kb_olk_ek4ndz_stamm                  COMMENT 'Kalkulationsbasis aus Stammdaten aktuell analog SAL DE bzw. KMO EK4n DEZENTRAL aus Stammdaten aktuell'
  ,a23_rohertrag_ekmep_olk_4n               COMMENT 'Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,a51_listung_sst_pflege                   COMMENT 'Sortimentsstufe (SST) gepflegt durch ZEK_1 (für KMO ohne K-Sortimentsstufe)'
  ,a52_listung_k_sst_pflege                 COMMENT 'K-Sortimentsstufe (K_SST) gepflegt durch ZEK_1 (nur KMO)'
  ,a426_ost_basis_pflege                    COMMENT 'Listung Ost Basis gepflegt durch ZEK_1'
  ,a427_ost_gross_pflege                    COMMENT 'Listung Ost Gross gepflegt durch ZEK_1'
  ,a428_sued_ost_pflege                     COMMENT 'Listung  Süd Ost  gepflegt durch ZEK_1'
  ,a429_sued_west_pflege                    COMMENT 'Listung  Süd West  gepflegt durch ZEK_1'
  ,a430_west_pflege                         COMMENT 'Listung  West gepflegt durch ZEK_1'
  ,a431_nord_pflege                         COMMENT 'Listung  Nord gepflegt durch ZEK_1'
  ,a50_listungsaktion                       COMMENT 'Nur befüllt, wenn ZEK_1 Eingaben tätigt. Fall 1: ZEK_1 wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK_1 wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.
ID 0: keine Listungsaktion
ID 1: keine Veränderung
ID 2: nicht möglich
ID 3: SOLL-Listung = IST-Listung
ID 4: Neulistung KL-Artikel_1
ID 5: Einlistung Kauflandartikel
ID 6: Einlistung Potenzialartikel
ID 7: Auslistung
ID 8: Listung erweitern
ID 9: Listung reduzieren
ID 10: Listung erweitern und reduzieren
ID 11: Listung reduzieren und erweitern
ID 12: Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'
  ,a411_stk_rohertrag_pflege                COMMENT 'Stück Rohertrag gepflegt durch ZEK_1 für Potentialartikel'
  ,a415_kannibalisierungsfaktor             COMMENT 'Gepflegt durch User um die Hochrechnungen zu multiplizieren (passiert in der View)'
  ,a412_umsatz_brutto_hochrechnung          COMMENT 'Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'
  ,a413_absatz_hochrechnung                 COMMENT 'Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'
  ,a414_rohertrag_hochrechnung              COMMENT 'Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'
  ,a36_gewichtete_distribution_nielsen      COMMENT 'Gewichtete Verteilung Nielsen-Artikel_1 (Pendant zu distribution_gewichtet KL-Daten)'
  ,a32_umsatz_anteil_wgi_nielsen            COMMENT 'Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'
  ,a33_umsatz_anteil_wgi_kumuliert_nielsen  COMMENT 'Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'
  ,a34_vk_brutto_durchschnitt_nielsen       COMMENT 'Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'
  ,a35_umsatz_nielsen                       COMMENT 'Gesamtumsatz Nielsen-Artikel_1'
  ,anz_wochen_de_anz_monate_kmo_nielsen     COMMENT 'Anzahl Wochen (DE) oder Monate (KMO) in denen der Nielsen-Artikel_1 Daten hat'
  ,absatz_nielsen                           COMMENT 'wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'
  ,a376_kl_marktanteil_wg_nielsen           COMMENT 'Marktanteil Kaufland  (Nielsen Daten)'
  ,a380_marktanteilbewertung_nielsen        COMMENT 'Marktanteilbewertung(wird im ETL-Prozess ermittelt)'
  ,a377_durchschnitt_anz_maerkte_nielsen    COMMENT 'Durschnittliche Anzahl Märkte (Nielsen Daten)'
  ,a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen COMMENT 'Absatz Nielsen Artikel_1 normiert auf Einheit (Liter, Kg, …).'
  ,a384_durchschn_preis_einheit_gl_normiert_nielsen COMMENT 'Ø-VK_1 Nielsen-Artikel_1 normiert auf Einheit (Liter, Kg, …).'
  ,a385_numerische_distribution_nielsen     COMMENT 'Numerische Distribution Nielsen.'
  ,a386_inhaltsmengen_nielsen               COMMENT 'Liste an Inhaltsmengen (Liter, ML, Kg, Gramm, …) des Nielsen-Artikels.'
  ,a387_duft_geschmack_nielsen              COMMENT 'Duft / Geschmacksrichtung (Nielsen Daten).'
  ,a388_einheit_nielsen                     COMMENT 'Einheiten, auf die sich der Werte in A386_INHALTSMENGEN_NIELSEN beziehen.'
  ,eigenmarke_fg_nielsen                    COMMENT 'eigenmarke_fg ermittelt aus Nielsen-Daten (1 = "SENSITIVE" oder "N/A "'
  ,a39_listung_sst_mvke                     COMMENT 'Listungsinformation (in KMO ohne K-Listung) - (MVKE_1 - art_sm_vw_zu_per_1)'
  ,a38_listung_k_sst_mvke                   COMMENT 'K-Listungsinformation - (MVKE_1 - art_sm_vw_zu_per_1) nur für KMO'
  ,a40_ost_basis                            COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a41_ost_gross                            COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a42_sued_ost                             COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a43_sued_west                            COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a44_west                                 COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a45_nord                                 COMMENT 'Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'
  ,a37_listung_erster_markt                 COMMENT 'min datum aller Artikel_1 des Tupels aus art_list_wup_zu_per_1 where list_quelle_id <> 2'
  ,a59_anz_maerkte_sst                      COMMENT 'Marktanzahl Sortimentsstufe (in KMO ohne "K") und Regio-Cluster (nur DE)'
  ,a449_anz_maerkte_k_sst                   COMMENT 'Marktanzahl K-Sortimentsstufe (nur KMO)'
  ,a46_max_anz_maerkte_sst                  COMMENT 'Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'
  ,a47_max_anz_maerkte_k_sst                COMMENT 'Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'
  ,a53_anz_maerkte_listung_gesamt           COMMENT 'Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per_1 ohne Listungsquelle 2 (Aktionslistung))'
  ,a57_anz_maerkte_listung_einzel           COMMENT 'Marktanzahl Einzellistung'
  ,anz_maerkte_baustein_sonstige            COMMENT 'Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'
  ,anz_bons_af                              COMMENT 'Zähler für: Bonreichweite aktionsfreie Ware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'
  ,anz_bons_sa                              COMMENT 'Zähler für: Bonreichweite Sonderaktionsware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'
  ,anz_bons_gesamt                          COMMENT 'Nenner für: Bonreichweite AF und SA'
  ,rohertrag_ekmep_olk_4n_vj                COMMENT 'Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_af                COMMENT 'Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_sa                COMMENT 'Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_af_vj             COMMENT 'hertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,rohertrag_ekmep_olk_4n_sa_vj             COMMENT 'Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'
  ,a381_preislagenverteilung                COMMENT 'Preislagenverteilung (wird im ETL-Prozess ermittelt)'
  ,a27_totalabschriften_wert_netto_absolut  COMMENT 'Abschriftensumme VK_1 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_1'
  ,a313_preisabschriften_preisanderungen_wert_netto_absolut COMMENT 'Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'
  ,totalabschriften_wert_netto_absolut_vj   COMMENT 'Abschriftensumme VK_1 netto VJ, nur Totalabschriften (Definition offen)'
  ,preisabschriften_preisanderungen_wert_netto_absolut_vj COMMENT 'Abschriften_1 VK_1 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'
  ,totalabschriften_wert_netto_absolut_wg   COMMENT 'Abschriftensumme VK_1 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'
  ,preisabschriften_preisanderungen_wert_netto_absolut_wg COMMENT 'Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'
  ,a402_kolli_la                            COMMENT 'Kolliinhalt Lagerabgangsmenge'
  ,a401_kolli_bst                           COMMENT 'Kolliinhalt Bestellmenge'
  ,a403_restlaufzeit_zl                     COMMENT 'Restlaufzeit bei Anlieferung an Zentrallager'
  ,a404_restlaufzeit_dz                     COMMENT 'Restlaufzeit bei dezentraler Belieferung'
  ,a405_basismengeneinheit                  COMMENT 'Entspricht Verkaufsmengeneinheit'
  ,a406_letzte_listungsanderung_sst_ksst    COMMENT 'Letzte Veränderung der Sortimentsttufenlistung aus Sternchenlogik'
  ,a407_verhandler                          COMMENT 'Verhandler INT oder Land_1'
  ,a408_display_komponente_kz               COMMENT 'Kennzeichen ob Artikel_1 Display Displaykomponente ist'
  ,a409_kl_art_id_display                   COMMENT 'Alle Displayartikelnummern die im Tupel vorkommen'
  ,a416_artikelrolle_id                     COMMENT 'Vom EK definierte Rolle des Artikels'
  ,kassenumsatz_kl_absolut_netto_wg         COMMENT 'Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'
  ,anz_bons_tupel                           COMMENT 'Anzahl Bons, auf denen der Artikel_1 enthalten ist (AF+SA). Nenner für Restbon'
  ,restbon_summe                            COMMENT 'Summe Kassenumsatz netto aller Bons aller Artikel_1 des Tupels. Zähler für Restbon'
  ,anz_bons_af_markt_tag                    COMMENT 'Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der aktionsfreie (AF) Artikel_1, verkauft wurde.'
  ,anz_bons_sa_markt_tag                    COMMENT 'Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der in Sonderaktion (SA) Artikel_1, verkauft wurde.'
  ,cpq_tupel                                COMMENT 'Cherrypicker Quote aus Shopper_1'
  ,cp_bons_af                               COMMENT 'Cherrpicker Bons AF auf denen der Artikel_1 verkauft wurde '
  ,cp_bons_sa                               COMMENT 'Cherrpicker Bons SA auf denen der Artikel_1 verkauft wurde '
  ,umrech_faktor                            COMMENT 'Gebindeberücksichtigung Flasche/Kiste'
  ,lagerprozent                             COMMENT 'Lagerprozentsatz, gibt an wieviel % der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird'
  ,absatz_af_kl_listungswochen              COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,absatz_af_kl_vj_listungswochen           COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,absatz_sa_kl_listungswochen              COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,absatz_sa_kl_vj_listungswochen           COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,kassenumsatz_af_kl_absolut_netto_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,kassenumsatz_af_kl_absolut_netto_vj_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,kassenumsatz_sa_kl_absolut_netto_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_af_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_af_vj_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_sa_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,rohertrag_ekmep_olk_4n_sa_vj_listungswochen COMMENT 'Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'
  ,a445_anz_tupel_listung_wgi               COMMENT 'Anzahl von Tupel Listung'
  ,sustain_concat                           COMMENT 'Alle Nachhaltigkeitskennzeichen konkatiniert, mit Komma getrennt, alphabetisch sortiert.'
  ,check_fg                                 COMMENT 'Check, if the data have been validated'
  ,tupel_typ                                COMMENT 'Used to distinguish between tupel types like KFL, Nielsen and Custom Articles.'
  ,a471_marke_nielsen_bez                   COMMENT 'Marken aus Quelle Nielsen.'
  ,a515_bio_organic_nielsen_kz              COMMENT 'Label Bio, nicht Bio, N/A oder unbekannt, aus Quelle Nielsen.'
  ,a516_veggy_split_nielsen_kz              COMMENT 'Label Vegetarisch, Vegan, N/A oder normal, aus Quelle Nielsen.'
  ,a517_laktosefrei_nielsen_kz              COMMENT 'Label laktosefrei, N/A oder normal, aus Quelle Nielsen.'
  ,a518_glutenfrei_nielsen_kz               COMMENT 'Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'
  ,a510_muki_ek_kz                          COMMENT 'Mutter-Kind-Kennzeichen (MUKI-KZ) aus SAP.'
  ,a511_muki_ek_kl_art_id_verkettung        COMMENT 'Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'
  ,a512_muki_wb_kz                          COMMENT 'Mutter-Kind-Kennzeichen (MUKI-KZ) aus Quelle SAP.'
  ,a513_muki_wb_kl_art_id_verkettung        COMMENT 'Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'
  ,a519_umsatz_anteil_wg_nielsen            COMMENT 'Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe.'
  ,a520_umsatz_anteil_wg_kumuliert_nielsen  COMMENT 'Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe, Kumulation nach Rang aufsteigend.'
  ,a521_inhalt_menge                        COMMENT 'Inhaltsmenge aus SAP.'
)
COMMENT = 'EK_SORT - Faktentabelle - auf Ebene Tupel (Gruppierung aus n KL-Artikeln inkl. gematchten Artikeln vom Marktforschungsinstitut Nielsen) historisiert nach MAT (moving anual total) und KW.
Es ist eine_1 Zwischentabelle für BC und FB EK SORT um Daten auszusieben und zu entscheiden, was zur Analyse in die Tabelle tupel_mat_1 soll. Enhällt auch Aggregationen für Spalten aus Tabelle art_nielsen.'
 AS 
    SELECT 
        mandant_id,
        a500_kjwo_update,
        matching_id,
        a425_kjmo,
        wrg_id,
        a5_owg_id,
        a7_wg_id,
        wug_id,
        art_id,
        kl_art_id,
        a450_art_nielsen_nr,
        art_bez_deutsch,
        a14_art_status_de,
        nielsen_art_bez,
        nielsen_gtin,
        a58_rang_umsatz_owg,
        a2_rang_umsatz_wg,
        a59_rang_absatz_wg,
        a16_akt_lieferant_id,
        a419_hersteller_id,
        a446_lieferant_bez_latein,
        a447_hersteller_bez_latein,
        lieferant_nielsen,
        a389_zek_id,
        a391_disc_pe,
        a392_disc_ohne_etikett,
        a400_lcf,
        a393_vegan,
        a394_gluten,
        a395_bio,
        a396_eigenmarke,
        a397_tierwohl,
        a398_posten_food,
        a399_posten_nonfood,
        a339_umsatzsteuer,
        a60_muki_vk_kz,
        a61_muki_vk_kl_art_id_verkettung,
        anzahl_markt_wochen_kombis_abverkauf_af,
        anzahl_markt_wochen_kombis_abverkauf_sa,
        anzahl_markt_wochen_kombis_abverkauf_af_vj,
        anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        a273_kassenumsatz_kl_absolut_brutto,
        kassenumsatz_af_kl_absolut_brutto,
        kassenumsatz_sa_kl_absolut_brutto,
        kassenumsatz_kl_absolut_brutto_vj,
        kassenumsatz_af_kl_absolut_brutto_vj,
        kassenumsatz_sa_kl_absolut_brutto_vj,
        a21_kassenumsatz_kl_absolut_netto,
        kassenumsatz_af_kl_absolut_netto,
        kassenumsatz_sa_kl_absolut_netto,
        kassenumsatz_kl_absolut_netto_vj,
        kassenumsatz_af_kl_absolut_netto_vj,
        kassenumsatz_sa_kl_absolut_netto_vj,
        a17_absatz_kl,
        absatz_af_kl,
        absatz_sa_kl,
        absatz_kl_vj,
        absatz_af_kl_vj,
        absatz_sa_kl_vj,
        a76_absatz_sst1,
        a78_absatz_sst2,
        a80_absatz_sst3,
        a82_absatz_sst4,
        a84_absatz_sst5,
        a86_absatz_sst6,
        a88_absatz_sst7,
        a62_absatz_ksst1,
        a64_absatz_ksst2,
        a66_absatz_ksst3,
        a68_absatz_ksst4,
        a70_absatz_ksst5,
        a72_absatz_ksst6,
        a74_absatz_ksst7,
        a90_absatz_ost_basis,
        a92_absatz_ost_gross,
        a94_absatz_sued_ost,
        a96_absatz_sued_west,
        a98_absatz_west,
        a100_absatz_nord,
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
        a31_vk_brutto_kl_pk_1,
        a333_vk_brutto_kl_pk_2,
        a54_vk_brutto_kl_pk_3,
        a334_vk_brutto_kl_pk_4,
        a432_vk_brutto_kl_pk_5,
        a433_vk_brutto_kl_pk_6,
        a434_vk_brutto_kl_pk_7,
        a435_vk_brutto_kl_pk_8,
        a436_vk_brutto_kl_pk_9,
        a437_vk_brutto_kl_pk_10,
        a30_kb_olk_ek4ndz_stamm,
        a23_rohertrag_ekmep_olk_4n,
        a51_listung_sst_pflege,
        a52_listung_k_sst_pflege,
        a426_ost_basis_pflege,
        a427_ost_gross_pflege,
        a428_sued_ost_pflege,
        a429_sued_west_pflege,
        a430_west_pflege,
        a431_nord_pflege,
        a50_listungsaktion,
        a411_stk_rohertrag_pflege,
        a415_kannibalisierungsfaktor,
        a412_umsatz_brutto_hochrechnung,
        a413_absatz_hochrechnung,
        a414_rohertrag_hochrechnung,
        a36_gewichtete_distribution_nielsen,
        a32_umsatz_anteil_wgi_nielsen,
        a33_umsatz_anteil_wgi_kumuliert_nielsen,
        a34_vk_brutto_durchschnitt_nielsen,
        a35_umsatz_nielsen,
        anz_wochen_de_anz_monate_kmo_nielsen,
        absatz_nielsen,
        a376_kl_marktanteil_wg_nielsen,
        a380_marktanteilbewertung_nielsen,
        a377_durchschnitt_anz_maerkte_nielsen,
        a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
        a384_durchschn_preis_einheit_gl_normiert_nielsen,
        a385_numerische_distribution_nielsen,
        a386_inhaltsmengen_nielsen,
        a387_duft_geschmack_nielsen,
        a388_einheit_nielsen,
        eigenmarke_fg_nielsen,
        a39_listung_sst_mvke,
        a38_listung_k_sst_mvke,
        a40_ost_basis,
        a41_ost_gross,
        a42_sued_ost,
        a43_sued_west,
        a44_west,
        a45_nord,
        a37_listung_erster_markt,
        a59_anz_maerkte_sst,
        a449_anz_maerkte_k_sst,
        a46_max_anz_maerkte_sst,
        a47_max_anz_maerkte_k_sst,
        a53_anz_maerkte_listung_gesamt,
        a57_anz_maerkte_listung_einzel,
        anz_maerkte_baustein_sonstige,
        anz_bons_af,
        anz_bons_sa,
        anz_bons_gesamt,
        rohertrag_ekmep_olk_4n_vj,
        rohertrag_ekmep_olk_4n_af,
        rohertrag_ekmep_olk_4n_sa,
        rohertrag_ekmep_olk_4n_af_vj,
        rohertrag_ekmep_olk_4n_sa_vj,
        a381_preislagenverteilung,
        a27_totalabschriften_wert_netto_absolut,
        a313_preisabschriften_preisanderungen_wert_netto_absolut,
        totalabschriften_wert_netto_absolut_vj,
        preisabschriften_preisanderungen_wert_netto_absolut_vj,
        totalabschriften_wert_netto_absolut_wg,
        preisabschriften_preisanderungen_wert_netto_absolut_wg,
        a402_kolli_la,
        a401_kolli_bst,
        a403_restlaufzeit_zl,
        a404_restlaufzeit_dz,
        a405_basismengeneinheit,
        a406_letzte_listungsanderung_sst_ksst,
        a407_verhandler,
        a408_display_komponente_kz,
        a409_kl_art_id_display,
        a416_artikelrolle_id,
        kassenumsatz_kl_absolut_netto_wg,
        anz_bons_tupel,
        restbon_summe,
        anz_bons_af_markt_tag,
        anz_bons_sa_markt_tag,
        cpq_tupel,
        cp_bons_af,
        cp_bons_sa,
        umrech_faktor,
        lagerprozent,
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
        rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
        a445_anz_tupel_listung_wgi,
        sustain_concat,
        check_fg,
        tupel_typ,
        a471_marke_nielsen_bez,
        a515_bio_organic_nielsen_kz,
        a516_veggy_split_nielsen_kz,
        a517_laktosefrei_nielsen_kz,
        a518_glutenfrei_nielsen_kz,
        a510_muki_ek_kz,
        a511_muki_ek_kl_art_id_verkettung,
        a512_muki_wb_kz,
        a513_muki_wb_kl_art_id_verkettung,
        a519_umsatz_anteil_wg_nielsen,
        a520_umsatz_anteil_wg_kumuliert_nielsen,
        a521_inhalt_menge

FROM DBP_MSI_DATA.TUPEL_MAT_QUARANTAENE_1 ;