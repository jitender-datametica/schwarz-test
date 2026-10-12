--==============================================================
-- Table: ek_sort_sortiment_mat_zeitraum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ek_sort_sortiment_mat_zeitraum_2
   generated from Powerdesigner on Donnerstag, 20. Juli 2023 11:30:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 (
   kjmo_sort                           NUMBER(38,0)     NOT NULL COMMENT 'Monat_2 und Jahr der gültigen Daten von Nielsen. Daten werden üblicherweise 2 Monate verspätet zum aktuellen Kalendermonat geliefert. Daten der letzten 12 Monate vom aktuellen Monat_2 ausgehend, werden verarbeitet.
            
            Month and year of valid Nielsen data. Nielsen data is generally delayed by 2 months from the current calendar_2 months. Data is processed for the last 12 months from this month. ',
   kjwo_von                            NUMBER(38,0)     NOT NULL COMMENT 'Kalenderwoche in der der Zeitraum beginnt für den die Daten verarbeitet werden.,
            
            Initial range of process processing expressed in weeks for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.',
   kjwo_bis                            NUMBER(38,0)     NOT NULL COMMENT 'Kalenderwoche in der der Zeitraum endet für den die Daten verarbeitet werden. Üblicherweise 12 Monate nach beginn des Zeitraums.
            
            Final range of process processing expressed in weeks for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.',
   dat_von                             DATE             NOT NULL COMMENT 'Erster Tag_2 der Woche_2 in der die Verarbeitung der Daten beginnt.
            
            Initial range of process processing expressed in days for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.',
   dat_bis                             DATE             NOT NULL COMMENT 'Letzter Tag_2 der Woche_2 in der die Verarbeitung der Daten endet.
            
            Final range of process processing expressed in days for the last year. KJMO_SORT specifies the month from which the last 12 months are counted. ',
   monate_anz                          NUMBER(38,0)     COMMENT 'Anzahl der Monate für die Daten verarbeitet wurden.
            
            Number of months for which data is processed.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EK_SORT_SORTIMENT_MAT_ZEITRAUM PRIMARY KEY (kjmo_sort) NOT ENFORCED
)  COMMENT = 'Kontrollentität des Ladeprozesses für EK Sort zur Sortimentsauswahl als MAT (Moveing annual target) als Eingrenzungsmöglichkeit für die zügige Auswahl im Frontend.
             Enthält Zeitbereich für den Sortimentsdaten geladen werden mit gültigen Nielsendaten, üblicherweise der letzten 12 Monate.
             
             Control table of loading processes in the EK SORT application. It contains information about the periods and date ranges for which tables are loaded.
             Data loaded manually once a year for the following year
             (can be loaded once for 20-30 years ahead of time).
             
             Source - ETL Prozess manual
             Application - EK SORT';
