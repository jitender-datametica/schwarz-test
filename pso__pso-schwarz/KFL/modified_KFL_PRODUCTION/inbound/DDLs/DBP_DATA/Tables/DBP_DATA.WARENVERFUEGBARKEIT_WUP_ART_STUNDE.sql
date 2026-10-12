--==============================================================
-- Table: warenverfuegbarkeit_wup_art_stunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: warenverfuegbarkeit_wup_art_stunde
   generated from Powerdesigner on Dienstag, 27. August 2024 15:57:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WARENVERFUEGBARKEIT_WUP_ART_STUNDE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel verkauft wird.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
   art_id                              INTEGER     NOT NULL COMMENT 'ID des verkauften Artikel.',
   dat_auswertung                      DATE             NOT NULL COMMENT 'Datum der Auswertung im Format JJJJ-MM-TT.',
   zeit_stunde                         INTEGER     NOT NULL COMMENT 'Volle Stunde (00 bis 23) der Auswertung.',
   bewart_id                           INTEGER     COMMENT 'Bewegungsart des verkauften Artikels. 1002 = SA = Sonderaktion (Werbeartikel), 1001 = AF = Aktionsfrei (kein Werbeartikel)',
   anz_bon_artikel                     INTEGER     COMMENT 'Anzahl der Bons, in denen der Artikel in diesem Zeitraum verkauft wurde.',
   menge_verkauft                      NUMBER(29,3)     COMMENT 'Gesamtverkaufte Menge des Artikels in diesem Zeitraum. Es kann sowohl in Stück als auch in Kilogramm angegeben sein (je nach Artikel).',
   anz_bon_gesamt                      INTEGER     COMMENT 'Gesamtzahl der erstellten Bons in der Filiale in diesem Zeitraum. Unabhängig von der Anzahl der verkauften Artikel. Die Anzahl kann aufgrund von Abschriften und Retouren von den Daten in DBP_ODS.ODS_BON_VERKAUF abweichen.',
   ausverkauft_fg                      INTEGER     COMMENT 'Kennzeichen, das angibt, ob der Artikel in diesem Zeitraum vollständig ausverkauft war.',
   eckartikel_fg                       INTEGER     COMMENT 'Kennzeichen, das angibt ob der Artikel in diesem Zeitraum ein Eckartikel ist. Unter einem Eckartikel versteht man einen Artikel, auf den die Kunden besonders achten und der dementsprechend immer verfügbar sein sollte.',
   topseller_fg                        INTEGER     COMMENT 'Kennzeichen, das angibt, ob der Artikel einer der 25 meistverkauften Artikel der letzten 3 Jahre ist.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WARENVERFUEGBARKEIT_WUP_ART_STUNDE PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_auswertung, zeit_stunde) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält detaillierte Informationen über die stündliche Verfügbarkeit der Artikel. Sie bezieht sich nur auf O&G und Backartikel, die entweder Eckartikel oder Topseller sind. Sie dient der Analyse von Abverkäufen und Out-of-Stock-Situationen.';
