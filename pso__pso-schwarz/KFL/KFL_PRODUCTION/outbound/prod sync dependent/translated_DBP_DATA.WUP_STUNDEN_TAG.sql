CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_stunden_tag (
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum'),
stunden_markt NUMERIC(29,2)
OPTIONS(description='Nettostunden IST : geleistete Stunden in der Filiale - DE: Aggregation aus PEP - Ausland: Eingabe (Transaction) durch Filiale'),
stunden_sonstige NUMERIC(29,2)
OPTIONS(description='Nettostunden IST : zusätzliche Stunden, Umlage Stunden andere Filialen - INTEGER  : Eingabe (Transaction) durch Filiale'),
stunden_plan NUMERIC(29,2)
OPTIONS(description='Nettostunden Plan : geplante Stunden in der Filiale - INTEGER  : Eingabe (Transaction) durch Filiale'),
stunden_co5_sonstige NUMERIC(29,2) DEFAULT 0 NOT NULL OPTIONS(description='Spalte entfällt'),
ums_netto_plan NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz netto Plan : Tagesumsatzplanwert von CO (wup_plan_tag/vis_tag_umsatz_kunde_wup)'),
ums_netto_plan_man NUMERIC(29,2)
OPTIONS(description='Umsatz netto Plan HL : dient zur Berechnung der Nettoleistung HL  - INTEGER  : Eingabe (Transaction) durch Filiale'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
stunden_sonstige_plan NUMERIC(29,2)
OPTIONS(description='Nettostunden Plan : geplante Stunden für Sondersachverhalte - INTEGER  : Eingabe (Transaction) durch Filiale'),
stunden_co1_iks NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden IST : Korrekturposition z.B. Stundenkorrektur bei Falschpflege durch Markt (IKS) - Excelupload durch CO'),
stunden_co2_ea NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden IST : Korrekturposition z.B. Entlastung Einarbeitung - Excelupload durch CO'),
stunden_co3_anue NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden IST : Korrekturposition z.B. Entlastung Preiseinholung - Excelupload durch CO'),
stunden_co4_reinigung NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden IST / Nettostunden Plan : Korrekturposition z.B. Pauschalansatz Reinigung - Excelupload durch CO'),
stunden_plan_pep NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden Plan : geplante Stunden Filiale - DE : Aggregation aus PEP - Ausland: nicht verfügbar'),
stunden_plan_meldeschluss_plus1 NUMERIC(29,2)
OPTIONS(description='Nettostunden Plan zum Zeitpunkt des Meldeschluss  (Zahlen müssen zum 18. des Vormonats für den kompletten Monat gemeldet sein) - wird im ETL am 18. des Vormonats aus Spalte stunden_plan kopiert'),
ums_netto_plan_man_meldeschluss_plus2 NUMERIC(29,2)
OPTIONS(description='Umsatz netto Plan HL zum Zeitpunkt des Meldeschluss  (Zahlen müssen zum 26. des Vor-Vormonats für den kompletten Monat gemeldet sein) - wird im ETL am 26. des Vor-Vormonats aus Spalte ums_netto_plan_man kopiert'),
stunden_co_ist NUMERIC(29,2)
OPTIONS(description='Summe der Bereiche aus Excelbeladung - Excelpflege durch Controlling. Externe IST Stunden (z.B. Reinigung durch ext. Firma)'),
stunden_co_plan NUMERIC(29,2)
OPTIONS(description='Summe der Bereiche aus Excelbeladung - Excelpflege durch Controlling. Externe PLAN Stunden (z.B. Reinigung durch ext. Firma)'),
stunden_plan_meldeschluss_plus2 NUMERIC(29,2)
OPTIONS(description='26. Folge-Folge. Wird im ETL am 26. des Vor-Vormonats aus Spalte stunden_plan kopiert'),
ums_netto_plan_man_meldeschluss_plus1 NUMERIC(29,2)
OPTIONS(description='18. Folge. Wird im ETL am 18. des Vormonats aus Spalte ums_netto_plan_man kopiert'),
stunden_co_plan_plus1 NUMERIC(29,2)
OPTIONS(description='18. Folge Monat. Wird im ETL am 18. des Vormonats aus Spalte stunden_co_plan kopiert'),
stunden_co_plan_plus2 NUMERIC(29,2)
OPTIONS(description='26. Folge-Folge Monat. Wird im ETL am 18. des Vor-Vormonats aus Spalte stunden_co_plan kopiert.'),
stunden_sonstige_plan_plus1 NUMERIC(29,2)
OPTIONS(description='18. Folge Monat. Wird im ETL am 18. des Vormonats aus Spalte stunden_sonstige_plan kopiert.'),
stunden_sonstige_plan_plus2 NUMERIC(29,2)
OPTIONS(description='26. Folge-Folge Monat. Wird im ETL am 26. des Vor-Vormonats aus Spalte stunden_sonstige_plan kopiert.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
stunden_plan_ssm NUMERIC(29,2) OPTIONS(description='Nettostunden Plan aus SSM(Smartes Stunden Modell).'),
stunden_versetzung NUMERIC(29,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettostunden IST : Stunden fuer untertaegige Versetzungen - INTEGER  : Eingabe (Transaction) durch Filiale'),
PRIMARY KEY (wup_id, nb_id, mandant_id, dat) NOT ENFORCED
)
OPTIONS(description='VIS - geleistete Stunden pro Tag und Markt. Quellen sind PEP-Daten oder per Transaction Service im DWH erfasste Daten');