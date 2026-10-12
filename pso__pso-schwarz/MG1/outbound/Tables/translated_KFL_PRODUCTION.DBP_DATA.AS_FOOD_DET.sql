DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.AS_FOOD_DET;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AS_FOOD_DET (
ART_ID INTEGER NOT NULL OPTIONS(description='Artikelnummer im DWH'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
DAT_AUSLISTUNG DATE NOT NULL OPTIONS(description='Das Datum der Auslistung aus dem Quellfeld aldat'),
KJWO INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
PHASE_WO INTEGER NOT NULL
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Wird aus dem Quellfeld alweek befüllt. Referenz zur Tabelle woche'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
ERL_KZ STRING(1) NOT NULL OPTIONS(description='Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'),
DAT_FINAL DATE OPTIONS(description='Datum Laufzeitende aus dem Quellfeld final'),
AS_FINAL_STATUS_ID INTEGER
OPTIONS(description='Klassifizierung der Datensätze nach Status des ausgelisteten Sortiments nachdem dat_final vorhanden ist. 0 = default / Kein Restbestand ; 1 = Absatz, trotz Finaldatum; 2 = Finaldatum, aber keine ERL-KZ = D (Abschrift)'),
PHASE_ID INTEGER NOT NULL OPTIONS(description='ID ergibt sich aus ALWEEK (ID = 0), WEEK01 (ID = 1), usw'),
PHASE_VK_BRUTTO NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis brutto aus dem Quellfeld vkpr01,vkpr02 usw. (VK der jeweiligen Phase) - Wert bezieht sich auf komplette Phase'),
PHASE_VK_NETTO NUMERIC(9,2) NOT NULL
OPTIONS(description='wird aus phase_vk_brutto errechnet (reduziert um MwSt-Betrag) - Wert bezieht sich auf komplette Phase'),
MENGE_TOTALABSCHRIFT NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften)'),
BETRAG_TOTALABSCHRIFT_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag netto der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften)'),
MENGE_PREISABSCHRIFT NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften)'),
BETRAG_PREISABSCHRIFT_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag netto der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften)'),
MENGE_ENDBESTAND_PHASE NUMERIC(18,3) NOT NULL
OPTIONS(description='Endbestand pro Phasenende - Wert bezieht sich nicht auf KJWO, sondern Ende der Phase'),
MENGE_ENDBESTAND NUMERIC(29,3)
OPTIONS(description='Endbestand pro Kalenderwoche - aus DWH-Tabelle marktbestand_erp. In der laufenden Woche beinhaltet die Spalte den Bestand des Vortages, in allen vergangenen Kalenderwochen, den Endbestand dieser KJWO.'),
MENGE_ABSATZ NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge des Absatz - aus DWH-Tabelle artbew (dient zum tagesgenauen Auslesen der Absaetze fuer die laenderspezifischen Phasenzeitraeume)'),
UMSATZ_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag - aus DWH-Tabelle artbew (dient zum tagesgenauen Auslesen der Umsaetze fuer die laenderspezifischen Phasenzeiträume)'),
BETRAG_EK_NETTONETTO NUMERIC(29,4)
OPTIONS(description='Summe der Einkaufspreise nettonetto (Bedeutung vgl. Kalkulationsschema). - Wert aus DWH-Tabelle artbew_wo_sum.'),
BETRAG_EK_MEP NUMERIC(29,4)
OPTIONS(description='Summe der Markteinstandspreise (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
BETRAG_EINSTANDSPREIS NUMERIC(29,4)
OPTIONS(description='Summe der Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
BETRAG_LOGKOSTENZUSCHLAG NUMERIC(29,4)
OPTIONS(description='Summe der Logistikkostenzuschläge (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist). -aus DWH-Tabelle artbew_wo_sum.'),
BETRAG_EK_MEP_VOR_FWU NUMERIC(29,4)
OPTIONS(description='Summe der Markteinstandspreise vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen\"alten\" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.- aus DWH-Tabelle artbew_wo_sum.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, NB_ID, WUP_ID, DAT_AUSLISTUNG, KJWO) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='AIS - Auslistungs-Schema Detailtabelle aus der Quelltabelle zrs_rvdata');