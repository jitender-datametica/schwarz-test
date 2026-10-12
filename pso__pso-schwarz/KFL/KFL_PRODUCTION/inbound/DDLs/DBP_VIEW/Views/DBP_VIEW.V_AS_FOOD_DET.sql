CREATE OR REPLACE VIEW DBP_VIEW.V_AS_FOOD_DET (
   art_id                                   COMMENT 'Artikelnummer im DWH'
  ,mandant_id                               COMMENT 'Mandant im DWH'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,wup_id                                   COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,dat_auslistung                           COMMENT 'Das Datum der Auslistung aus dem Quellfeld aldat'
  ,kjwo                                     COMMENT 'Kalenderjahreswoche. Format JJJJWW'
  ,phase_wo                                 COMMENT 'Kalenderjahreswoche. Format JJJJWW. Wird aus dem Quellfeld alweek befüllt. Referenz zur Tabelle woche'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'
  ,erl_kz                                   COMMENT 'Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'
  ,dat_final                                COMMENT 'Datum Laufzeitende aus dem Quellfeld final'
  ,as_final_status_id                       COMMENT 'Klassifizierung der Datensätze nach Status des ausgelisteten Sortiments nachdem dat_final vorhanden ist. 0 = default / Kein Restbestand ; 1 = Absatz, trotz Finaldatum; 2 = Finaldatum, aber keine ERL-KZ = D (Abschrift)'
  ,phase_id                                 COMMENT 'ID ergibt sich aus ALWEEK (ID = 0), WEEK01 (ID = 1), usw'
  ,phase_vk_brutto                          COMMENT 'Verkaufspreis brutto aus dem Quellfeld vkpr01,vkpr02 usw. (VK der jeweiligen Phase) - Wert bezieht sich auf komplette Phase'
  ,phase_vk_netto                           COMMENT 'wird aus phase_vk_brutto errechnet (reduziert um MwSt-Betrag) - Wert bezieht sich auf komplette Phase'
  ,menge_totalabschrift                     COMMENT 'Menge der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften)'
  ,betrag_totalabschrift_netto              COMMENT 'Betrag netto der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften)'
  ,menge_preisabschrift                     COMMENT 'Menge der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften)'
  ,betrag_preisabschrift_netto              COMMENT 'Betrag netto der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften)'
  ,menge_endbestand_phase                   COMMENT 'Endbestand pro Phasenende - Wert bezieht sich nicht auf KJWO, sondern Ende der Phase'
  ,menge_endbestand                         COMMENT 'Endbestand pro Kalenderwoche - aus DWH-Tabelle marktbestand_erp. In der laufenden Woche beinhaltet die Spalte den Bestand des Vortages, in allen vergangenen Kalenderwochen, den Endbestand dieser KJWO.'
  ,menge_absatz                             COMMENT 'Menge des Absatz - aus DWH-Tabelle artbew (dient zum tagesgenauen Auslesen der Absaetze fuer die laenderspezifischen Phasenzeitraeume)'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag - aus DWH-Tabelle artbew (dient zum tagesgenauen Auslesen der Umsaetze fuer die laenderspezifischen Phasenzeiträume)'
  ,betrag_ek_nettonetto                     COMMENT 'Summe der Einkaufspreise nettonetto (Bedeutung vgl. Kalkulationsschema). - Wert aus DWH-Tabelle artbew_wo_sum.'
  ,betrag_ek_mep                            COMMENT 'Summe der Markteinstandspreise (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'
  ,betrag_einstandspreis                    COMMENT 'Summe der Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'
  ,betrag_logkostenzuschlag                 COMMENT 'Summe der Logistikkostenzuschläge (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist). -aus DWH-Tabelle artbew_wo_sum.'
  ,betrag_ek_mep_vor_fwu                    COMMENT 'Summe der Markteinstandspreise vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.- aus DWH-Tabelle artbew_wo_sum.'
)
COMMENT = 'AIS - Auslistungs-Schema Detailtabelle aus der Quelltabelle zrs_rvdata'
 AS 
    SELECT 
        art_id,
        mandant_id,
        nb_id,
        wup_id,
        dat_auslistung,
        kjwo,
        phase_wo,
        wrg_id,
        erl_kz,
        dat_final,
        as_final_status_id,
        phase_id,
        phase_vk_brutto,
        phase_vk_netto,
        menge_totalabschrift,
        betrag_totalabschrift_netto,
        menge_preisabschrift,
        betrag_preisabschrift_netto,
        menge_endbestand_phase,
        menge_endbestand,
        menge_absatz,
        umsatz_netto,
        betrag_ek_nettonetto,
        betrag_ek_mep,
        betrag_einstandspreis,
        betrag_logkostenzuschlag,
        betrag_ek_mep_vor_fwu

FROM DBP_DATA.AS_FOOD_DET ;