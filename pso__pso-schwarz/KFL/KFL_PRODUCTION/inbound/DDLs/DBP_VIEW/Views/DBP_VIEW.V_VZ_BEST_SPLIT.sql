CREATE OR REPLACE VIEW DBP_VIEW.V_VZ_BEST_SPLIT (
   mandant_id                               COMMENT 'Mandant           '
  ,gp_dispo_id                              COMMENT 'Supplier ID   (surrogate key)    '
  ,best_beleg_dispo_id                      COMMENT 'Bestell-ID '
  ,art_dispo_id                             COMMENT 'Artikel ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. 
Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '
  ,bestellart_id                            COMMENT 'Bestellart   '
  ,einkaeufer_grp_id                        COMMENT 'Einkäufergruppe'
  ,wup_id                                   COMMENT 'Betrieb'
  ,nb_id                                    COMMENT 'Nebenbetrieb'
  ,gp_id                                    COMMENT 'Kontonummer des Lieferanten bzw. Kreditors'
  ,disponent_id                             COMMENT 'Disponent'
  ,gp_teilsortiment_id                      COMMENT 'Lieferantenteilsortiment       '
  ,fremd_lagerort_id                        COMMENT 'Vorschlagslagerort für Fremdbeschaffung'
  ,art_id                                   COMMENT 'Artikelnummer       '
  ,menge_gesamt                             COMMENT 'Menge Gesamt  '
  ,menge_iwt_gesamt                         COMMENT 'IWT Menge Gesamt  '
  ,menge_normal                             COMMENT 'Menge Normal     '
  ,menge_iwt                                COMMENT 'Menge IWT'
  ,menge_werbung_gesamt                     COMMENT 'Werbung Menge Gesamt '
  ,menge_werbung                            COMMENT 'Menge Werbung  '
  ,menge_einh_id                            COMMENT 'Bestellmengenheit'
  ,dat_lief_wunsch                          COMMENT 'Lieferdatum der Position   '
  ,kontrakt_beleg_id                        COMMENT 'Kontrakt'
  ,kontrakt_beleg_pos_id                    COMMENT 'Kontrakt Pos '
  ,best_beleg_id                            COMMENT 'Belegnummer des Einkaufsbelegs'
  ,best_beleg_pos_id                        COMMENT 'EinkBeleg Pos.   '
  ,vz_dispo_status_id                       COMMENT 'VZ Dispo Status   '
  ,palettenfaktor                           COMMENT 'Palettenfaktor   '
  ,gewicht_brutto_bme                       COMMENT 'Bruttogewicht BME '
  ,dat_verfuegbarkeit                       COMMENT 'Verfügb.Datum'
  ,faktor_bestme_bme                        COMMENT 'Umrechenfaktor Bestellmengeheit in Basismengeneinheit    '
  ,gewicht_pal                              COMMENT 'Gewicht volle PAL       '
  ,gewicht_gesamt                           COMMENT 'Gesamtgewicht Position'
  ,anz_plaetze_max                          COMMENT 'Anzahl der maximalen Plätze   '
  ,gewicht_ladung_max                       COMMENT 'Maximal zulässiges Ladungsgewicht in KG'
  ,planlieferzeit                           COMMENT 'Planlieferzeit in Tagen '
  ,autodispo_fg                             COMMENT 'Feld zum Ankreuzen    '
  ,wg_id                                    COMMENT 'Warengruppe     '
  ,menge_werbung_gesamt_pal                 COMMENT 'Gesamtmenge Werbung PAL '
  ,menge_best_pal                           COMMENT 'Bestellmenge PAL  '
  ,menge_best_werbung_pal                   COMMENT 'Werbe. BestellM PAL  '
  ,menge_iwt_gesamt_pal                     COMMENT 'IWT Gesamtmenge PAL    '
  ,menge_iwt_pal                            COMMENT 'IWT BestellM PAL'
  ,splitsource_id                           COMMENT 'Splitsource '
  ,menge_bevorratung                        COMMENT 'Menge Bevorratung    '
  ,bedarfsnummer                            COMMENT 'Bedarfsnummer             '
  ,ursprungsprozess                         COMMENT 'Ursprungsprozess'
  ,best_vor_dispo_id                        COMMENT 'ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'
)
COMMENT = 'Order-Split '
 AS 
    SELECT 
        mandant_id,
        gp_dispo_id,
        best_beleg_dispo_id,
        art_dispo_id,
        bestellart_id,
        einkaeufer_grp_id,
        wup_id,
        nb_id,
        gp_id,
        disponent_id,
        gp_teilsortiment_id,
        fremd_lagerort_id,
        art_id,
        menge_gesamt,
        menge_iwt_gesamt,
        menge_normal,
        menge_iwt,
        menge_werbung_gesamt,
        menge_werbung,
        menge_einh_id,
        dat_lief_wunsch,
        kontrakt_beleg_id,
        kontrakt_beleg_pos_id,
        best_beleg_id,
        best_beleg_pos_id,
        vz_dispo_status_id,
        palettenfaktor,
        gewicht_brutto_bme,
        dat_verfuegbarkeit,
        faktor_bestme_bme,
        gewicht_pal,
        gewicht_gesamt,
        anz_plaetze_max,
        gewicht_ladung_max,
        planlieferzeit,
        autodispo_fg,
        wg_id,
        menge_werbung_gesamt_pal,
        menge_best_pal,
        menge_best_werbung_pal,
        menge_iwt_gesamt_pal,
        menge_iwt_pal,
        splitsource_id,
        menge_bevorratung,
        bedarfsnummer,
        ursprungsprozess,
        best_vor_dispo_id

FROM DBP_DATA.VZ_BEST_SPLIT ;