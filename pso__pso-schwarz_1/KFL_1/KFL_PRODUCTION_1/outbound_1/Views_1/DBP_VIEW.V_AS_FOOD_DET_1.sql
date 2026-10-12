CREATE OR REPLACE VIEW kfl_production_dbp_view.v_as_food_det_1 (art_id OPTIONS(description='Artikelnummer im DWH'),
mandant_id OPTIONS(description='Mandant_1 im DWH'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), dat_auslistung
OPTIONS(description='Das Datum der Auslistung aus dem Quellfeld aldat'), kjwo
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'), phase_wo
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Wird aus dem Quellfeld alweek befüllt. Referenz zur Tabelle woche_1'),
wrg_id OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), erl_kz
OPTIONS(description='Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'), dat_final
OPTIONS(description='Datum Laufzeitende aus dem Quellfeld final'), as_final_status_id
OPTIONS(description='Klassifizierung der Datensätze nach Status_1 des ausgelisteten Sortiments nachdem dat_final vorhanden ist. 0 = default / Kein Restbestand ; 1 = Absatz, trotz Finaldatum; 2 = Finaldatum, aber keine ERL-KZ = D (Abschrift)'),
phase_id OPTIONS(description='ID ergibt sich aus ALWEEK (ID = 0), WEEK01 (ID = 1), usw'), phase_vk_brutto
OPTIONS(description='Verkaufspreis brutto aus dem Quellfeld vkpr01,vkpr02 usw. (VK_1 der jeweiligen Phase) - Wert bezieht sich auf komplette Phase'),
phase_vk_netto
OPTIONS(description='wird aus phase_vk_brutto errechnet (reduziert um MwSt-Betrag) - Wert bezieht sich auf komplette Phase'),
menge_totalabschrift
OPTIONS(description='Menge der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_1)'),
betrag_totalabschrift_netto
OPTIONS(description='Betrag netto der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_1)'),
menge_preisabschrift
OPTIONS(description='Menge der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_1)'),
betrag_preisabschrift_netto
OPTIONS(description='Betrag netto der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_1)'),
menge_endbestand_phase
OPTIONS(description='Endbestand pro Phasenende - Wert bezieht sich nicht auf KJWO, sondern Ende der Phase'),
menge_endbestand
OPTIONS(description='Endbestand pro Kalenderwoche - aus DWH-Tabelle marktbestand_erp. In der laufenden Woche_1 beinhaltet die Spalte den Bestand des Vortages, in allen vergangenen Kalenderwochen, den Endbestand dieser KJWO.'),
menge_absatz
OPTIONS(description='Menge des Absatz - aus DWH-Tabelle artbew_1 (dient zum tagesgenauen Auslesen der Absaetze fuer die laenderspezifischen Phasenzeitraeume)'),
umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag - aus DWH-Tabelle artbew_1 (dient zum tagesgenauen Auslesen der Umsaetze fuer die laenderspezifischen Phasenzeiträume)'),
betrag_ek_nettonetto
OPTIONS(description='Summe der Einkaufspreise nettonetto (Bedeutung vgl. Kalkulationsschema). - Wert aus DWH-Tabelle artbew_wo_sum.'),
betrag_ek_mep
OPTIONS(description='Summe der Markteinstandspreise (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
betrag_einstandspreis
OPTIONS(description='Summe der Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
betrag_logkostenzuschlag
OPTIONS(description='Summe der Logistikkostenzuschläge (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist). -aus DWH-Tabelle artbew_wo_sum.'),
betrag_ek_mep_vor_fwu
OPTIONS(description='Summe der Markteinstandspreise vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.- aus DWH-Tabelle artbew_wo_sum.'))
OPTIONS(DESCRIPTION = `AIS - AUSLISTUNGS-SCHEMA DETAILTABELLE AUS DER QUELLTABELLE ZRS_RVDATA`) AS SELECT art_id,
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
FROM kfl_production_dbp_data.as_food_det_1;