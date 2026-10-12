--==============================================================
-- Table: as_food_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_food_det_1
   generated from Powerdesigner on Freitag, 25. Juli 2025 15:11:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.as_food_det_1 (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer im DWH'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
dat_auslistung DATE NOT NULL OPTIONS(description='Das Datum der Auslistung aus dem Quellfeld aldat'),
kjwo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
phase_wo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Wird aus dem Quellfeld alweek befüllt. Referenz zur Tabelle woche_1'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
erl_kz STRING(1) NOT NULL OPTIONS(description='Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'),
dat_final DATE OPTIONS(description='Datum Laufzeitende aus dem Quellfeld final'),
as_final_status_id BIGNUMERIC(38,0)
OPTIONS(description='Klassifizierung der Datensätze nach Status_1 des ausgelisteten Sortiments nachdem dat_final vorhanden ist. 0 = default / Kein Restbestand ; 1 = Absatz, trotz Finaldatum; 2 = Finaldatum, aber keine ERL-KZ = D (Abschrift)'),
phase_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID ergibt sich aus ALWEEK (ID = 0), WEEK01 (ID = 1), usw'),
phase_vk_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis brutto aus dem Quellfeld vkpr01,vkpr02 usw. (VK_1 der jeweiligen Phase) - Wert bezieht sich auf komplette Phase'),
phase_vk_netto NUMERIC(9,2) NOT NULL
OPTIONS(description='wird aus phase_vk_brutto errechnet (reduziert um MwSt-Betrag) - Wert bezieht sich auf komplette Phase'),
menge_totalabschrift NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_1)'),
betrag_totalabschrift_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag netto der Totalabschriften (für DE AKZ = 122; KMO aus DWH-Tabelle marktabschriften_1)'),
menge_preisabschrift NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_1)'),
betrag_preisabschrift_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag netto der Preisabschriften (für DE AKZ = 22; KMO aus DWH-Tabelle marktabschriften_1)'),
menge_endbestand_phase NUMERIC(18,3) NOT NULL
OPTIONS(description='Endbestand pro Phasenende - Wert bezieht sich nicht auf KJWO, sondern Ende der Phase'),
menge_endbestand BIGNUMERIC(38,3)
OPTIONS(description='Endbestand pro Kalenderwoche - aus DWH-Tabelle marktbestand_erp. In der laufenden Woche_1 beinhaltet die Spalte den Bestand des Vortages, in allen vergangenen Kalenderwochen, den Endbestand dieser KJWO.'),
menge_absatz NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge des Absatz - aus DWH-Tabelle artbew_1 (dient zum tagesgenauen Auslesen der Absaetze fuer die laenderspezifischen Phasenzeitraeume)'),
umsatz_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag - aus DWH-Tabelle artbew_1 (dient zum tagesgenauen Auslesen der Umsaetze fuer die laenderspezifischen Phasenzeiträume)'),
betrag_ek_nettonetto BIGNUMERIC(38,4)
OPTIONS(description='Summe der Einkaufspreise nettonetto (Bedeutung vgl. Kalkulationsschema). - Wert aus DWH-Tabelle artbew_wo_sum.'),
betrag_ek_mep BIGNUMERIC(38,4)
OPTIONS(description='Summe der Markteinstandspreise (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
betrag_einstandspreis BIGNUMERIC(38,4)
OPTIONS(description='Summe der Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema). - aus DWH-Tabelle artbew_wo_sum.'),
betrag_logkostenzuschlag BIGNUMERIC(38,4)
OPTIONS(description='Summe der Logistikkostenzuschläge (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist). -aus DWH-Tabelle artbew_wo_sum.'),
betrag_ek_mep_vor_fwu BIGNUMERIC(38,4)
OPTIONS(description='Summe der Markteinstandspreise vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.- aus DWH-Tabelle artbew_wo_sum.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, nb_id, wup_id, dat_auslistung, kjwo) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='AIS - Auslistungs-Schema Detailtabelle aus der Quelltabelle zrs_rvdata');