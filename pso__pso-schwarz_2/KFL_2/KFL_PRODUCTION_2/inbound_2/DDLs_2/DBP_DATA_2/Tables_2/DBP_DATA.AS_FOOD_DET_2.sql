--==============================================================
-- Table: as_food_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_food_det_2
   generated from Powerdesigner on Freitag, 25. Juli 2025 15:11:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AS_FOOD_DET_2 CLUSTER BY (MANDANT_ID) (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer im DWH',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   dat_auslistung                      DATE             NOT NULL COMMENT 'Das Datum der Auslistung aus dem Quellfeld aldat',
   kjwo                                NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   phase_wo                            NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW. Wird aus dem Quellfeld alweek befüllt. Referenz zur Tabelle woche_2',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   erl_kz                              VARCHAR(1)       NOT NULL COMMENT 'Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz',
   dat_final                           DATE             COMMENT 'Datum Laufzeitende aus dem Quellfeld final',
   as_final_status_id                  NUMBER(38,0)     COMMENT 'Klassifizierung der Datensätze nach Status_2 des ausgelisteten Sortiments nachdem dat_final vorhanden ist. 0 = default / Kein Restbestand ; 1 = Absatz, trotz Finaldatum; 2 = Finaldatum, aber keine ERL-KZ = D (Abschrift)',
   phase_id                            NUMBER(38,0)     NOT NULL COMMENT 'ID ergibt sich aus ALWEEK (ID = 0), WEEK01 (ID = 1), usw',
   phase_vk_brutto                     NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis brutto aus dem Quellfeld vkpr01,vkpr02 usw. (VK_2 der jeweiligen Phase) - Wert bezieht sich auf komplette Phase',
   phase_vk_netto                      NUMBER(9,2)      NOT NULL COMMENT 'wird aus phase_vk_brutto errechnet (reduziert um MwSt-Betrag) - Wert bezieht sich auf komplette Phase',
   menge_totalabschrift                NUMBER(18,3)     NOT NULL COMMENT 'Menge der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_2)',
   betrag_totalabschrift_netto         NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag netto der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_2)',
   menge_preisabschrift                NUMBER(18,3)     NOT NULL COMMENT 'Menge der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_2)',
   betrag_preisabschrift_netto         NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag netto der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_2)',
   menge_endbestand_phase              NUMBER(18,3)     NOT NULL COMMENT 'Endbestand pro Phasenende - Wert bezieht sich nicht auf KJWO, sondern Ende der Phase',
   menge_endbestand                    NUMBER(38,3)     COMMENT 'Endbestand pro Kalenderwoche - aus DWH-Tabelle marktbestand_erp. In der laufenden Woche_2 beinhaltet die Spalte den Bestand des Vortages, in allen vergangenen Kalenderwochen, den Endbestand dieser KJWO.',
   menge_absatz                        NUMBER(18,3)     NOT NULL COMMENT 'Menge des Absatz - aus DWH-Tabelle artbew_2 (dient zum tagesgenauen Auslesen der Absaetze fuer die laenderspezifischen Phasenzeitraeume)',
   umsatz_netto                        NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag - aus DWH-Tabelle artbew_2 (dient zum tagesgenauen Auslesen der Umsaetze fuer die laenderspezifischen Phasenzeiträume)',
   betrag_ek_nettonetto                NUMBER(38,4)     COMMENT 'Summe der Einkaufspreise nettonetto (Bedeutung vgl. Kalkulationsschema). - Wert aus DWH-Tabelle artbew_wo_sum.',
   betrag_ek_mep                       NUMBER(38,4)     COMMENT 'Summe der Markteinstandspreise (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.',
   betrag_einstandspreis               NUMBER(38,4)     COMMENT 'Summe der Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.',
   betrag_logkostenzuschlag            NUMBER(38,4)     COMMENT 'Summe der Logistikkostenzuschläge (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist). -aus DWH-Tabelle artbew_wo_sum.',
   betrag_ek_mep_vor_fwu               NUMBER(38,4)     COMMENT 'Summe der Markteinstandspreise vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.- aus DWH-Tabelle artbew_wo_sum.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AS_FOOD_DET PRIMARY KEY (art_id, mandant_id, nb_id, wup_id, dat_auslistung, kjwo) NOT ENFORCED
)  COMMENT = 'AIS - Auslistungs-Schema Detailtabelle aus der Quelltabelle zrs_rvdata';
