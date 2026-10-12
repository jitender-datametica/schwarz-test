/* --------------------------------------------------------------------------------
   DDL for table: t_txj_515
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_txj_515 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION'),
record_cd STRING(12) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Belegnummer: 4 Stellen Filiale, 6 Stellen Datum ?JJMMTT", 2 Stellen fortlaufende Nummer pro TA pro Tag'),
turnover_val NUMERIC(18,5)
OPTIONS(description='Ist-Umsatz: IST-Summe Bar + Abschopfung + Karte + IST-FW (Gegenwert in Stammwahrung)'),
turnover_calc_val NUMERIC(18,5)
OPTIONS(description='Soll-Umsatz: Summe aller Warenverkaufe ? Ruckgaben ? Bonabbruch - Zei-lenstorni - Pfandruckgaben - Rundungsdifferenzen (ohne Be-achtung von Kassierdifferen-zen)'),
withdrawal_val NUMERIC(18,5) OPTIONS(description='Abschoepfung: Teil von Umsatz Ist bzw. Soll Gesamt'),
rounding_diff NUMERIC(18,5)
OPTIONS(description='Summe aller Rundungsdifferenzen (aus Stuckelung oder / und Fremdwahrung)'),
total_diff NUMERIC(18,5) OPTIONS(description='Differenz gesamt: Wird ermittelt aus Gesamt Ist ? Gesamt Soll'),
customer_cnt BIGNUMERIC(38,0) OPTIONS(description='Kundenanzahl'),
receipt_neg_turnover_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl aller Bons mit Summe kleiner 0 ("negative Bons")'),
receipt_neg_turnover_val NUMERIC(18,5) OPTIONS(description='Wert aller Bons mit Summe kleiner 0 ("negative Bons"'),
line_per_minute_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Bonzeilen / Min.\';'),
line_per_customer_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Bonzeilen je Kunde'),
receipt_authorized_abort_cnt BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Autorisierter Bon-Abbruch (Vertastung mit Schluessel)'),
receipt_authorized_abort_val NUMERIC(18,5)
OPTIONS(description='Wert Autorisierter Bon-Abbruch (Vertastung mit Schluessel)'),
receipt_automatic_abort_cnt BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Automatischer Bon-Abbruch nach Papierende oder Stromausfall'),
receipt_automatic_abort_val NUMERIC(18,5)
OPTIONS(description='Wert Automatischer Bon-Abbruch nach Papierende oder Stromausfall'),
voids_instantly_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Sofort-Zeilenstorno: Storno letzter Eingabe'),
voids_instantly_val NUMERIC(18,5) OPTIONS(description='Wert Sofort-Zeilenstorno: Storno letzter Eingabe'),
voids_any_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Storno einer beliebigen Zeile im Bon'),
voids_any_val NUMERIC(18,5) OPTIONS(description='Wert Storno einer beliebigen Zeile im Bon'),
returns_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Rueckgaben'),
returns_val NUMERIC(18,5) OPTIONS(description='Wert Rueckgaben'),
discounts_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Rabatt'),
discounts_val NUMERIC(18,5) OPTIONS(description='Wert Rabatt'),
reusable_deposit_sales_val NUMERIC(18,5) OPTIONS(description='Summe Wert Verkauf Warengruppe Mehrweg'),
reusable_deposit_returns_val NUMERIC(18,5) OPTIONS(description='Summe Wert Ruecknahme Warengruppe Mehrweg'),
single_use_deposit_sales_val NUMERIC(18,5) OPTIONS(description='Summe Wert Verkauf Warengruppe Einweg'),
single_use_deposit_returns_val NUMERIC(18,5) OPTIONS(description='Summe Wert Ruecknahme Warengruppe Einweg'),
deposit_return_man_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Ruecknahme Leergut ueber Kassentastatur'),
deposit_return_man_val NUMERIC(18,5) OPTIONS(description='Wert Ruecknahme Leergut ueber Kassentastatur'),
deposit_return_scan_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Ruecknahme uber Scannen von Pfandbelegen'),
deposit_return_scan_val NUMERIC(18,5) OPTIONS(description='Wert Ruecknahme uber Scannen von Pfandbelegen'),
item_sales_scan_cnt BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Artikel Scanner: Scannen + Art.Nr. + PLU + Produkttaste (z.B. Tragetasche)'),
item_sales_man_cnt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Artikel direkt: Nur uber WGR-Tasten'),
apply_diff NUMERIC(18,5) OPTIONS(description='Gesamtanmeldezeit'),
service_dur BIGNUMERIC(38,0)
OPTIONS(description='Service-Zeitdauer (Minuten): Erfassung des 1. Artikels bis zur Summenbildung'),
payment_dur BIGNUMERIC(38,0)
OPTIONS(description='Zeitdauer Zahlvorgang (Minuten): Zeit von Summenbildung bis Schlie?ung Geldlade'),
break_dur BIGNUMERIC(38,0) OPTIONS(description='Zeitdauer (Minuten) Kasse in ?Pause"'),
training_dur BIGNUMERIC(38,0) OPTIONS(description='Gesamtzeitdauer(Minuten) Schulungsmodus'),
waiting_dur BIGNUMERIC(38,0)
OPTIONS(description='Wartezeit(Minuten) : ab Anmeldung Bediener bis zur Erfassung des 1. Artikels ODER Beendigung Zahlvorgang (Schlie?ung Geld-lade) bis Neuerfassung nachster Artikel (neuer Kunde)'),
first_cash_return_tmsp DATETIME OPTIONS(description='Uhrzeit der ersten Geldruckgabe'),
last_cash_return_tmsp DATETIME OPTIONS(description='Uhrzeit der letzten Geldruckgabe'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Datum, auf das sich der Beleg bezieht'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='$Revision: 11324 $ TXJ Satzart 515 : Taegliche Statistik fuer Verkaeufe, Rueckgaeben,Rabatten usw. pro Filial pro Tag             ');