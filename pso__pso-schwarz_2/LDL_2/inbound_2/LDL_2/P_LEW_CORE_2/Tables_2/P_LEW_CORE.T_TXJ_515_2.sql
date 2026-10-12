/* --------------------------------------------------------------------------------
   DDL for table: t_txj_515_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_TXJ_515_2 CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_2',
   record_cd                           VARCHAR(12)      NOT NULL COLLATE 'en-ci' COMMENT 'Belegnummer: 4 Stellen Filiale, 6 Stellen Datum ?JJMMTT", 2 Stellen fortlaufende Nummer pro TA pro Tag_2',
   turnover_val                        NUMBER(18,5)     COMMENT 'Ist-Umsatz: IST-Summe Bar + Abschopfung + Karte + IST-FW (Gegenwert in Stammwahrung)',
   turnover_calc_val                   NUMBER(18,5)     COMMENT 'Soll-Umsatz: Summe aller Warenverkaufe ? Ruckgaben ? Bonabbruch - Zei-lenstorni - Pfandruckgaben - Rundungsdifferenzen (ohne Be-achtung von Kassierdifferen-zen)',
   withdrawal_val                      NUMBER(18,5)     COMMENT 'Abschoepfung: Teil von Umsatz Ist bzw. Soll Gesamt',
   rounding_diff                       NUMBER(18,5)     COMMENT 'Summe aller Rundungsdifferenzen (aus Stuckelung oder / und Fremdwahrung)',
   total_diff                          NUMBER(18,5)     COMMENT 'Differenz gesamt: Wird ermittelt aus Gesamt Ist ? Gesamt Soll',
   customer_cnt                        NUMBER(38,0)     COMMENT 'Kundenanzahl',
   receipt_neg_turnover_cnt            NUMBER(38,0)     COMMENT 'Anzahl aller Bons mit Summe kleiner 0 ("negative Bons")',
   receipt_neg_turnover_val            NUMBER(18,5)     COMMENT 'Wert aller Bons mit Summe kleiner 0 ("negative Bons"',
   line_per_minute_cnt                 NUMBER(38,0)     COMMENT 'Anzahl Bonzeilen / Min.'';',
   line_per_customer_cnt               NUMBER(38,0)     COMMENT 'Anzahl Bonzeilen je Kunde',
   receipt_authorized_abort_cnt        NUMBER(38,0)     COMMENT 'Anzahl Autorisierter Bon-Abbruch (Vertastung mit Schluessel)',
   receipt_authorized_abort_val        NUMBER(18,5)     COMMENT 'Wert Autorisierter Bon-Abbruch (Vertastung mit Schluessel)',
   receipt_automatic_abort_cnt         NUMBER(38,0)     COMMENT 'Anzahl Automatischer Bon-Abbruch nach Papierende oder Stromausfall',
   receipt_automatic_abort_val         NUMBER(18,5)     COMMENT 'Wert Automatischer Bon-Abbruch nach Papierende oder Stromausfall',
   voids_instantly_cnt                 NUMBER(38,0)     COMMENT 'Anzahl Sofort-Zeilenstorno: Storno letzter Eingabe',
   voids_instantly_val                 NUMBER(18,5)     COMMENT 'Wert Sofort-Zeilenstorno: Storno letzter Eingabe',
   voids_any_cnt                       NUMBER(38,0)     COMMENT 'Anzahl Storno einer beliebigen Zeile im Bon',
   voids_any_val                       NUMBER(18,5)     COMMENT 'Wert Storno einer beliebigen Zeile im Bon',
   returns_cnt                         NUMBER(38,0)     COMMENT 'Anzahl Rueckgaben',
   returns_val                         NUMBER(18,5)     COMMENT 'Wert Rueckgaben',
   discounts_cnt                       NUMBER(38,0)     COMMENT 'Anzahl Rabatt',
   discounts_val                       NUMBER(18,5)     COMMENT 'Wert Rabatt',
   reusable_deposit_sales_val          NUMBER(18,5)     COMMENT 'Summe Wert Verkauf Warengruppe Mehrweg',
   reusable_deposit_returns_val        NUMBER(18,5)     COMMENT 'Summe Wert Ruecknahme Warengruppe Mehrweg',
   single_use_deposit_sales_val        NUMBER(18,5)     COMMENT 'Summe Wert Verkauf Warengruppe Einweg',
   single_use_deposit_returns_val      NUMBER(18,5)     COMMENT 'Summe Wert Ruecknahme Warengruppe Einweg',
   deposit_return_man_cnt              NUMBER(38,0)     COMMENT 'Anzahl Ruecknahme Leergut ueber Kassentastatur',
   deposit_return_man_val              NUMBER(18,5)     COMMENT 'Wert Ruecknahme Leergut ueber Kassentastatur',
   deposit_return_scan_cnt             NUMBER(38,0)     COMMENT 'Anzahl Ruecknahme uber Scannen von Pfandbelegen',
   deposit_return_scan_val             NUMBER(18,5)     COMMENT 'Wert Ruecknahme uber Scannen von Pfandbelegen',
   item_sales_scan_cnt                 NUMBER(38,0)     COMMENT 'Anzahl Artikel_2 Scanner: Scannen + Art.Nr. + PLU + Produkttaste (z.B. Tragetasche)',
   item_sales_man_cnt                  NUMBER(38,0)     COMMENT 'Anzahl Artikel_2 direkt: Nur uber WGR-Tasten',
   apply_diff                          NUMBER(18,5)     COMMENT 'Gesamtanmeldezeit',
   service_dur                         NUMBER(38,0)     COMMENT 'Service-Zeitdauer (Minuten): Erfassung des 1. Artikels bis zur Summenbildung',
   payment_dur                         NUMBER(38,0)     COMMENT 'Zeitdauer Zahlvorgang (Minuten): Zeit_2 von Summenbildung bis Schlie?ung Geldlade',
   break_dur                           NUMBER(38,0)     COMMENT 'Zeitdauer (Minuten) Kasse in ?Pause"',
   training_dur                        NUMBER(38,0)     COMMENT 'Gesamtzeitdauer(Minuten) Schulungsmodus',
   waiting_dur                         NUMBER(38,0)     COMMENT 'Wartezeit(Minuten) : ab Anmeldung Bediener bis zur Erfassung des 1. Artikels ODER Beendigung Zahlvorgang (Schlie?ung Geld-lade) bis Neuerfassung nachster Artikel_2 (neuer Kunde)',
   first_cash_return_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Uhrzeit der ersten Geldruckgabe',
   last_cash_return_tmsp               TIMESTAMP_NTZ(9) COMMENT 'Uhrzeit der letzten Geldruckgabe',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Datum, auf das sich der Beleg bezieht',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_TXJ_515 PRIMARY KEY (client_id, loc_sid, record_cd, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 11324 $ TXJ Satzart 515 : Taegliche Statistik fuer Verkaeufe, Rueckgaeben,Rabatten usw. pro Filial pro Tag_2
             ';

