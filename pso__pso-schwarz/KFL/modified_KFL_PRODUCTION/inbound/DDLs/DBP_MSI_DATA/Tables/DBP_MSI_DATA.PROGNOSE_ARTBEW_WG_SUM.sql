--==============================================================
-- Table: prognose_artbew_wg_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: prognose_artbew_wg_sum
   generated from Powerdesigner on Freitag, 19. Mai 2023 14:44:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.PROGNOSE_ARTBEW_WG_SUM CLUSTER BY (
     MANDANT_ID,
     DAT_PROGNOSELAUF,
     DAT 
)
DATA_RETENTION_TIME_IN_DAYS = 1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_id                               INTEGER     NOT NULL COMMENT 'Warengruppe',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT, Bezugsdatum der Prognose aus udf_prognose',
   dat_prognoselauf                    DATE             NOT NULL COMMENT 'Datum des Prognoselaufs (ENTRY_DATE) aus udf_prognose an dem die Prognose erstellt wurde',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   udf_prognose_horizont               NUMBER(29,3)     COMMENT 'Anzahl Tage Prognosehorizont UDF (<= 100)',
   fur_prognose_horizont               NUMBER(29,3)     COMMENT 'Anzahl Tage Prognosehorizont F&R (<= 80)',
   udf_vk_menge                        NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT UDF-Prognose',
   udf_vk_menge_sa                     NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT UDF-Prognose (nur Sonderaktion)',
   udf_vk_menge_af                     NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT UDF-Prognose (nur Aktionsfrei)',
   udf_menge_prognose                  NUMBER(29,3)     COMMENT 'Menge Prognose in BME (UDF, nur Aktionsfrei)',
   udf_menge_prognose_sa               NUMBER(29,3)     COMMENT 'Menge Prognose in BME (UDF)',
   udf_menge_prognose_af               NUMBER(29,3)     COMMENT 'Menge Prognose in BME (UDF, nur Sonderaktion)',
   udf_abs_diff                        NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose UDF',
   udf_abs_diff_sa                     NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose UDF (nur Sonderaktion)',
   udf_abs_diff_af                     NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose UDF (nur Aktionsfrei)',
   udf_gesteuert_menge_prognose        NUMBER(29,3)     COMMENT 'Mengegesteuerte Prognose in BME (UDF, nur Aktionsfrei)',
   udf_gesteuert_menge_prognose_sa     NUMBER(29,3)     COMMENT 'Menge gesteuerte Prognose in BME (UDF)',
   udf_gesteuert_menge_prognose_af     NUMBER(29,3)     COMMENT 'Menge gesteuerte Prognose in BME (UDF, nur Sonderaktion)',
   udf_gesteuert_abs_diff              NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/gesteuerte Prognose UDF',
   udf_gesteuert_abs_diff_sa           NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/gesteuerte Prognose UDF (nur Sonderaktion)',
   udf_gesteuert_abs_diff_af           NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/gesteuerte Prognose UDF (nur Aktionsfrei)',
   fur_menge_prognose                  NUMBER(29,3)     COMMENT 'Menge mittlere Prognose in BME (F&R)',
   fur_menge_prognose_sa               NUMBER(29,3)     COMMENT 'Menge mittlere Prognose in BME (F&R, nur Sonderaktion)',
   fur_menge_prognose_af               NUMBER(29,3)     COMMENT 'Menge mittlere Prognose in BME (F&R, nur Aktionsfrei)',
   fur_menge_prognose_max              NUMBER(29,3)     COMMENT 'Menge max. Prognose in BME (F&R)',
   fur_vk_menge                        NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT F&R-Prognose',
   fur_vk_menge_sa                     NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT F&R-Prognose (nur Sonderaktion)',
   fur_vk_menge_af                     NUMBER(29,3)     COMMENT 'Menge Absatz in BME für Datensätze MIT F&R-Prognose (nur Aktionsfrei)',
   fur_abs_diff                        NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose F&R',
   fur_abs_diff_sa                     NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose F&R (nur Sonderaktion)',
   fur_abs_diff_af                     NUMBER(29,3)     COMMENT 'Absolute Differenz Absatz/Prognose F&R (nur Aktionsfrei)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PROGNOSE_ARTBEW_WG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, dat_prognoselauf, wg_id) NOT ENFORCED
)  COMMENT = 'Vergleich verschiedener Prognosen auf Ebene von Mandant, Warenumschlagplatz, Nebenbestriebskennziffer, Warengruppe, Datum für das prognostiziert wird und Datum an dem die Prognose erstellt wurde.
             Erstellung der Prognosen erfolgt täglich und automatisiert.
             
             BME = Basismengeneinheit, BME ist über Warengruppe nicht zwangsläufig additiv, da Stück und Gewicht gemischt möglich sind, dem Fachbereich bekannt.
             
             Sonderaktion oder Aktionsfrei oder keins davon wird über aktionslistung_fg in Tabelle "aktion" gesteuert ( 0=keines, 1=Sonderaktion, null=Aktionsfrei ).
             
             Werte in Spalten mit "gesteuert" werden für Anpassungen durch Nutzer beim nächsten Lauf bestimmt, Nutzer gibt Bedarfseinflussfaktor in SAP an.';
