CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 (
KJMO_SORT INTEGER NOT NULL
OPTIONS(description='Monat_2 und Jahr der gültigen Daten von Nielsen. Daten werden üblicherweise 2 Monate verspätet zum aktuellen Kalendermonat geliefert. Daten der letzten 12 Monate vom aktuellen Monat_2 ausgehend, werden verarbeitet.\n\n            Month and year of valid Nielsen data. Nielsen data is generally delayed by 2 months from the current calendar_2 months. Data is processed for the last 12 months from this month. '),
KJWO_VON INTEGER NOT NULL
OPTIONS(description='Kalenderwoche in der der Zeitraum beginnt für den die Daten verarbeitet werden.,\n\n            Initial range of process processing expressed in weeks for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.'),
KJWO_BIS INTEGER NOT NULL
OPTIONS(description='Kalenderwoche in der der Zeitraum endet für den die Daten verarbeitet werden. Üblicherweise 12 Monate nach beginn des Zeitraums.\n\n            Final range of process processing expressed in weeks for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.'),
DAT_VON DATE NOT NULL
OPTIONS(description='Erster Tag_2 der Woche_2 in der die Verarbeitung der Daten beginnt.\n\n            Initial range of process processing expressed in days for the last year. KJMO_SORT specifies the month from which the last 12 months are counted.'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Letzter Tag_2 der Woche_2 in der die Verarbeitung der Daten endet.\n\n            Final range of process processing expressed in days for the last year. KJMO_SORT specifies the month from which the last 12 months are counted. '),
MONATE_ANZ INTEGER
OPTIONS(description='Anzahl der Monate für die Daten verarbeitet wurden.\n\n            Number of months for which data is processed.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (KJMO_SORT) NOT ENFORCED
)
OPTIONS(description='Kontrollentität des Ladeprozesses für EK Sort zur Sortimentsauswahl als MAT (Moveing annual target) als Eingrenzungsmöglichkeit für die zügige Auswahl im Frontend.\n             Enthält Zeitbereich für den Sortimentsdaten geladen werden mit gültigen Nielsendaten, üblicherweise der letzten 12 Monate.\n\n             Control table of loading processes in the EK SORT application. It contains information about the periods and date ranges for which tables are loaded.\n             Data loaded manually once a year for the following year\n             (can be loaded once for 20-30 years ahead of time).\n\n             Source - ETL Prozess manual\n             Application - EK SORT');