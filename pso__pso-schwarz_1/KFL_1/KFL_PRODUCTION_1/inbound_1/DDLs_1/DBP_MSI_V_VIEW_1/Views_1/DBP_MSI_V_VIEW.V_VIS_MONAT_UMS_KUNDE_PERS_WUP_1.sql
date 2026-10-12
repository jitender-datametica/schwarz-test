CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_VIS_MONAT_UMS_KUNDE_PERS_WUP_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,wup_id                                   COMMENT 'Nummer des Warenumschlagsplatzes'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,kjmo                                     COMMENT 'Kalenderjahremonat, Format JJJJMM'
  ,gj                                       COMMENT 'Geschäftsjahr'
  ,akt_gj                                   COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres'
  ,akt_mo                                   COMMENT 'Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1'
  ,mo_kj                                    COMMENT 'Laufender Monat_1 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'
  ,ums_netto                                COMMENT 'Umsatz netto (K0-1) > lfd. Monat_1 aus Kasse'
  ,ums_netto_kvj                            COMMENT 'Umsatz netto (K0-1) Vorjahr'
  ,ums_netto_kvvj                           COMMENT 'Umsatz netto (K0-1) Vor-Vorjahr'
  ,ums_netto_plan                           COMMENT 'Umsatz netto (K0-1 Plan'
  ,ums_netto_plan_extern                    COMMENT 'Umsatz netto Planwert extern'
  ,anz_kunde                                COMMENT 'Anzahl Kunden'
  ,anz_kunde_kvj                            COMMENT 'Anzahl Kunden Kalendertag im Vorjahr'
  ,anz_kunde_kvvj                           COMMENT 'Anzahl Kunden Kalendertag im Vorvorjahr'
  ,anz_offen                                COMMENT 'Anzahl Öffnungstage'
  ,anz_offen_kvj                            COMMENT 'Anzahl Öffnungstage Kalendertag im Vorjahr'
  ,anz_offen_kvvj                           COMMENT 'Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'
  ,rohertrag                                COMMENT 'Rohertrag (K111)'
  ,rohertrag_kum                            COMMENT 'Rohertrag (K111) kum.'
  ,rohertrag_kvj                            COMMENT 'Rohertrag (K111) Vorjahr'
  ,rohertrag_kvj_kum                        COMMENT 'Rohertrag (K111) Vorjahr kum.'
  ,rohertrag_plan                           COMMENT 'Rohertrag (K111) Plan'
  ,rohertrag_plan_kum                       COMMENT 'Rohertrag (K111) Plan kum.'
  ,pers_kosten                              COMMENT 'Personal Kosten Gesamt (K2) > Vormonat aus XLS'
  ,pers_kosten_kum                          COMMENT 'Personal Kosten Gesamt (K2) kum > Vormonat aus XLS'
  ,pers_kosten_kvj                          COMMENT 'Personal Kosten Gesamt (K2) Vorjahr'
  ,pers_kosten_kvj_kum                      COMMENT 'Personal Kosten Gesamt (K2) Vorjahr kum.'
  ,pers_kosten_plan                         COMMENT 'Personal Kosten Gesamt (K2) Plan'
  ,pers_kosten_plan_kum                     COMMENT 'Personal Kosten Gesamt (K2) Plan kum.'
  ,pers_k_ohne                              COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1) > Vormonat aus XLS'
  ,pers_k_ohne_kum                          COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1)  kum > Vormonat aus XLS'
  ,pers_k_ohne_kvj                          COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1) Vorjahr'
  ,pers_k_ohne_kvj_kum                      COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1) Vorjahr kum.'
  ,pers_k_ohne_plan                         COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1) Plan'
  ,pers_k_ohne_plan_kum                     COMMENT 'Personalkosten_1 ohne Abgrenzung (K2-1) Plan kum.'
  ,pers_std                                 COMMENT 'Personal Stunden_1'
  ,pers_std_kum                             COMMENT 'Personal Stunden_1'
  ,pers_std_kvj                             COMMENT 'Personal Stunden_1'
  ,pers_std_kvj_kum                         COMMENT 'Personal Stunden_1'
  ,pers_std_plan                            COMMENT 'Personal Stunden_1'
  ,pers_std_plan_kum                        COMMENT 'Personal Stunden_1'
  ,pers_auq                                 COMMENT 'AU-Quote (Arbeitsunfähigkeit)'
  ,pers_auq_kum                             COMMENT 'AU-Quote (Arbeitsunfähigkeit)'
  ,pers_auq_kvj                             COMMENT 'AU-Quote (Arbeitsunfähigkeit)'
  ,pers_auq_kvj_kum                         COMMENT 'AU-Quote (Arbeitsunfähigkeit)'
  ,pers_fluq                                COMMENT 'Fluktuations-Quote'
  ,pers_fluq_kum                            COMMENT 'Fluktuations-Quote'
  ,pers_fluq_kvj                            COMMENT 'Fluktuations-Quote'
  ,pers_fluq_kvj_kum                        COMMENT 'Fluktuations-Quote'
)
COMMENT = 'VIS - Aggregat auf Monatsebene - MULTISET - Beladung aus wup_plan_tag_1'
 AS 
    SELECT 
        mandant_id,
        nb_id,
        wup_id,
        wrg_id,
        kjmo,
        gj,
        akt_gj,
        akt_mo,
        mo_kj,
        ums_netto,
        ums_netto_kvj,
        ums_netto_kvvj,
        ums_netto_plan,
        ums_netto_plan_extern,
        anz_kunde,
        anz_kunde_kvj,
        anz_kunde_kvvj,
        anz_offen,
        anz_offen_kvj,
        anz_offen_kvvj,
        rohertrag,
        rohertrag_kum,
        rohertrag_kvj,
        rohertrag_kvj_kum,
        rohertrag_plan,
        rohertrag_plan_kum,
        pers_kosten,
        pers_kosten_kum,
        pers_kosten_kvj,
        pers_kosten_kvj_kum,
        pers_kosten_plan,
        pers_kosten_plan_kum,
        pers_k_ohne,
        pers_k_ohne_kum,
        pers_k_ohne_kvj,
        pers_k_ohne_kvj_kum,
        pers_k_ohne_plan,
        pers_k_ohne_plan_kum,
        pers_std,
        pers_std_kum,
        pers_std_kvj,
        pers_std_kvj_kum,
        pers_std_plan,
        pers_std_plan_kum,
        pers_auq,
        pers_auq_kum,
        pers_auq_kvj,
        pers_auq_kvj_kum,
        pers_fluq,
        pers_fluq_kum,
        pers_fluq_kvj,
        pers_fluq_kvj_kum

FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1 ;