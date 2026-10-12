CREATE OR REPLACE VIEW DBP_VIEW.V_AKTIONSMANAGEMENT (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kjwo_ww                                  COMMENT 'Werbewoche, Format JJJJWW.'
  ,kjwo                                     COMMENT 'Kalenderjahreswoche. Format JJJJWW.'
  ,mutter_wb_id                             COMMENT 'Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel-ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'
  ,konkat_kind_art_id                       COMMENT 'Enthält alle Artikel-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,konkat_aktion_thema_gruppe_id            COMMENT 'Enthält alle Aktionsthemen konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,konkat_werbe_kat_id                      COMMENT 'Enthält alle Werbekategorien konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,konkat_werbeteam_cd                      COMMENT 'Enthält alle Werbeteams der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,konkat_werbeteam_bez                     COMMENT 'Enthält alle Werbeteams Bezeichnung der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,gp_id                                    COMMENT 'Geschäftspartner-ID (auch Lieferanten-ID).'
  ,werbebereich_cd                          COMMENT 'Code des Werbebereichs.'
  ,konkat_wg_id                             COMMENT 'Enthält alle WG-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'
  ,umsatz_netto_sa_west                     COMMENT 'Nettoumsatz / Kassenumsatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,absatz_sa_west                           COMMENT 'Absatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,ek_mep_sa_west                           COMMENT 'EK MEP SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,rohertrag_ek_mep_olk_sa_west             COMMENT 'Rohertrag EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,spanne_ek_mep_olk_sa_west                COMMENT 'Spanne EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,preisvorteil_west                        COMMENT 'Preisvorteil der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'
  ,umsatz_netto_sa_ost                      COMMENT 'Nettoumsatz/Kassenumsatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,absatz_sa_ost                            COMMENT 'Absatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,ek_mep_sa_ost                            COMMENT 'EK MEP SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,rohertrag_ek_mep_olk_sa_ost              COMMENT 'Rohertrag EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,spanne_ek_mep_olk_sa_ost                 COMMENT 'Spanne EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,preisvorteil_ost                         COMMENT 'Preisvorteil der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'
  ,umsatz_netto_sa_sued                     COMMENT 'Nettoumsatz/Kassenumsatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,absatz_sa_sued                           COMMENT 'Absatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,ek_mep_sa_sued                           COMMENT 'EK MEP SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,rohertrag_ek_mep_olk_sa_sued             COMMENT 'Rohertrag EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,spanne_ek_mep_olk_sa_sued                COMMENT 'Spanne EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,preisvorteil_sued                        COMMENT 'Preisvorteil der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'
  ,umsatz_netto_sa                          COMMENT 'Nettoumsatz/Kassenumsatz SA gesamt.'
  ,absatz_sa                                COMMENT 'Absatz SA gesamt.'
  ,ek_mep_sa                                COMMENT 'EK MEP SA gesamt.'
  ,rohertrag_sa                             COMMENT 'Rohertrag EK MEP oLK SA gesamt.'
  ,spanne_sa                                COMMENT 'Spanne EK MEP oLK SA gesamt.'
  ,preisvorteil                             COMMENT 'Preisvorteil gesamt.'
  ,avq_1                                    COMMENT 'Abverkaufsquote (1. Tag).'
  ,avq_3                                    COMMENT 'Abverkaufsquote (1.-3. Tag).'
  ,avq                                      COMMENT 'Abverkaufsquote gesamt (Woche).'
  ,wareneingang_zl                          COMMENT 'Wareneingang (ZL).'
  ,abverkaufte_menge_bestand                COMMENT 'Abverkaufte Menge (WE+Bestand).'
  ,abverkaufte_menge                        COMMENT 'Abverkaufte Menge.'
  ,durchschnitt_menge_pro_filiale           COMMENT 'Ø-Menge pro Artikel pro Filiale.'
  ,einheit_wb                               COMMENT 'Einheit WB: Stk/kg.'
  ,umsatz_netto                             COMMENT 'Umsatz netto/Kassenumsatz.'
  ,durchschnitt_umsatz_pro_artike           COMMENT 'Ø-Umsatz pro Artikel pro Filiale. (ACHTUNG: Die Spalte sollte eigentlich "durchschnitt_umsatz_pro_artikel_pro_filiale" heißen, wurde aber bei der Migration abgeschnitten und übersehen. Der Aufwand für eine Anpassung ist möglicherweise zu groß aufgrund der Berichte die daran hängen.)'
  ,anz_nullbestand                          COMMENT 'Anzahl Nullbestände.'
  ,nullbestandsquote                        COMMENT 'Nullbestandsquote Werbung.'
  ,endbestand                               COMMENT 'Endbestand.'
  ,umschlagsquote                           COMMENT 'Umschlagsdauer (Tage).'
  ,anz_artikel                              COMMENT 'Anzahl Artikel.'
  ,anz_filialen                             COMMENT 'Anzahl Filialen.'
  ,umsatz_baseline                          COMMENT 'Umsatz Baseline.'
  ,umsatz_werbewoche                        COMMENT 'Umsatz Werbewoche.'
  ,umsatz_uplift                            COMMENT 'Umsatz Uplift.'
  ,umsatz_aktivierter_normalpreis           COMMENT 'Umsatz aktivierter Normalpreis.'
  ,absatz_baseline                          COMMENT 'Absatz Baseline.'
  ,absatz_werbewoche                        COMMENT 'Absatz Werbewoche.'
  ,absatz_uplift                            COMMENT 'Absatz Uplift.'
  ,ertrag_baseline                          COMMENT 'Ertrag Baseline.'
  ,ertrag_werbewoche                        COMMENT 'Ertrag Werbewoche.'
  ,ertrag_uplift                            COMMENT 'Ertrag Uplift.'
  ,kaeufer_baseline                         COMMENT 'Kaeufer Baseline.'
  ,kaeufer_werbewoche                       COMMENT 'Kaeufer Werbewoche.'
  ,kaeufer_uplift                           COMMENT 'Kaeufer Uplift.'
  ,kaeufer_reichweite_baseline              COMMENT 'Kaeufer Reichweite Baseline.'
  ,kaeufer_reichweite_werbewoche            COMMENT 'Kaeufer Reichweite Werbewoche.'
  ,kaeufer_reichweite_uplift                COMMENT 'Kaeufer Reichweite Uplift.'
  ,cherrypicker_pp                          COMMENT 'Cherrypicker Quote.'
  ,restbon_normalware                       COMMENT 'Restbon Normalware.'
  ,restbon_gesamt                           COMMENT 'Restbon gesamt.'
  ,restbon_tip                              COMMENT 'Restbon TIP.'
  ,anz_tage_sa                              COMMENT 'Anzahl Tage SA. Aus Aggregat shopper.anz_tage_sa.'
  ,anz_markt_sa                             COMMENT 'Anzahl Markt SA.'
  ,baseline_wochen                          COMMENT 'Baseline Wochen.'
  ,wa_kalk_nach_pv_sa                       COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_sued                  COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion Süd ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_ost                   COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_west                  COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa                COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_sued           COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_ost            COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_west           COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_loy                   COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_aktion_loy            COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_bby_loy               COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_kdn_bby_loy           COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_kdp_bby_loy           COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_non_loy               COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_aktion_non_loy        COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,wa_kalk_nach_pv_sa_bby_non_loy           COMMENT 'Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_loy            COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_aktion_loy     COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_bby_loy        COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_kdn_bby_loy    COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_kdp_bby_loy    COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_non_loy        COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_aktion_non_loy COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,spanne_wa_kalk_nach_pv_sa_bby_non_loy    COMMENT 'Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'
  ,umsatz_netto_sa_aktion_loy               COMMENT 'Kassenumsatz netto Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,umsatz_netto_sa_bby_loy                  COMMENT 'Kassenumsatz netto Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,umsatz_netto_sa_kdn_bby_loy              COMMENT 'Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,umsatz_netto_sa_kdp_bby_loy              COMMENT 'Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,umsatz_netto_sa_aktion_non_loy           COMMENT 'Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,umsatz_netto_sa_bby_non_loy              COMMENT 'Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_aktion_loy                      COMMENT 'Absatz Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_bby_loy                         COMMENT 'Absatz Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_kdn_bby_loy                     COMMENT 'Absatz Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_kdp_bby_loy                     COMMENT 'Absatz Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_aktion_non_loy                  COMMENT 'Absatz Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,menge_sa_bby_non_loy                     COMMENT 'Absatz Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'
  ,pv_aktion_loy                            COMMENT 'Preisveränderung Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
  ,pv_bby_loy                               COMMENT 'Preisveränderung Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
  ,pv_kdn_bby                               COMMENT 'Preisveränderung Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
  ,pv_kdp_bby                               COMMENT 'Preisveränderung Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
  ,pv_aktion_non_loy                        COMMENT 'Preisveränderung nicht Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
  ,pv_bby_non_loy                           COMMENT 'Preisveränderung nicht Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'
)
COMMENT = 'Die Tabelle enthält Aggregate welche Daten aus dbp_data.artbew, dbp_data.werbung_kennzahlen_woche, dbp_data.shopper, dbp_data.marktabschriften und dbp_data.artbew_dat_ek_cp_sum vereinen. Fuehrende Quelle ist die artbew. Enthaelt nur DE.'
 AS 
    SELECT 
        mandant_id,
        kjwo_ww,
        kjwo,
        mutter_wb_id,
        konkat_kind_art_id,
        konkat_aktion_thema_gruppe_id,
        konkat_werbe_kat_id,
        konkat_werbeteam_cd,
        konkat_werbeteam_bez,
        gp_id,
        werbebereich_cd,
        konkat_wg_id,
        umsatz_netto_sa_west,
        absatz_sa_west,
        ek_mep_sa_west,
        rohertrag_ek_mep_olk_sa_west,
        spanne_ek_mep_olk_sa_west,
        preisvorteil_west,
        umsatz_netto_sa_ost,
        absatz_sa_ost,
        ek_mep_sa_ost,
        rohertrag_ek_mep_olk_sa_ost,
        spanne_ek_mep_olk_sa_ost,
        preisvorteil_ost,
        umsatz_netto_sa_sued,
        absatz_sa_sued,
        ek_mep_sa_sued,
        rohertrag_ek_mep_olk_sa_sued,
        spanne_ek_mep_olk_sa_sued,
        preisvorteil_sued,
        umsatz_netto_sa,
        absatz_sa,
        ek_mep_sa,
        rohertrag_sa,
        spanne_sa,
        preisvorteil,
        avq_1,
        avq_3,
        avq,
        wareneingang_zl,
        abverkaufte_menge_bestand,
        abverkaufte_menge,
        durchschnitt_menge_pro_filiale,
        einheit_wb,
        umsatz_netto,
        durchschnitt_umsatz_pro_artike,
        anz_nullbestand,
        nullbestandsquote,
        endbestand,
        umschlagsquote,
        anz_artikel,
        anz_filialen,
        umsatz_baseline,
        umsatz_werbewoche,
        umsatz_uplift,
        umsatz_aktivierter_normalpreis,
        absatz_baseline,
        absatz_werbewoche,
        absatz_uplift,
        ertrag_baseline,
        ertrag_werbewoche,
        ertrag_uplift,
        kaeufer_baseline,
        kaeufer_werbewoche,
        kaeufer_uplift,
        kaeufer_reichweite_baseline,
        kaeufer_reichweite_werbewoche,
        kaeufer_reichweite_uplift,
        cherrypicker_pp,
        restbon_normalware,
        restbon_gesamt,
        restbon_tip,
        anz_tage_sa,
        anz_markt_sa,
        baseline_wochen,
        wa_kalk_nach_pv_sa,
        wa_kalk_nach_pv_sa_sued,
        wa_kalk_nach_pv_sa_ost,
        wa_kalk_nach_pv_sa_west,
        spanne_wa_kalk_nach_pv_sa,
        spanne_wa_kalk_nach_pv_sa_sued,
        spanne_wa_kalk_nach_pv_sa_ost,
        spanne_wa_kalk_nach_pv_sa_west,
        wa_kalk_nach_pv_sa_loy,
        wa_kalk_nach_pv_sa_aktion_loy,
        wa_kalk_nach_pv_sa_bby_loy,
        wa_kalk_nach_pv_sa_kdn_bby_loy,
        wa_kalk_nach_pv_sa_kdp_bby_loy,
        wa_kalk_nach_pv_sa_non_loy,
        wa_kalk_nach_pv_sa_aktion_non_loy,
        wa_kalk_nach_pv_sa_bby_non_loy,
        spanne_wa_kalk_nach_pv_sa_loy,
        spanne_wa_kalk_nach_pv_sa_aktion_loy,
        spanne_wa_kalk_nach_pv_sa_bby_loy,
        spanne_wa_kalk_nach_pv_sa_kdn_bby_loy,
        spanne_wa_kalk_nach_pv_sa_kdp_bby_loy,
        spanne_wa_kalk_nach_pv_sa_non_loy,
        spanne_wa_kalk_nach_pv_sa_aktion_non_loy,
        spanne_wa_kalk_nach_pv_sa_bby_non_loy,
        umsatz_netto_sa_aktion_loy,
        umsatz_netto_sa_bby_loy,
        umsatz_netto_sa_kdn_bby_loy,
        umsatz_netto_sa_kdp_bby_loy,
        umsatz_netto_sa_aktion_non_loy,
        umsatz_netto_sa_bby_non_loy,
        menge_sa_aktion_loy,
        menge_sa_bby_loy,
        menge_sa_kdn_bby_loy,
        menge_sa_kdp_bby_loy,
        menge_sa_aktion_non_loy,
        menge_sa_bby_non_loy,
        pv_aktion_loy,
        pv_bby_loy,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_non_loy,
        pv_bby_non_loy

FROM DBP_DATA.AKTIONSMANAGEMENT ;