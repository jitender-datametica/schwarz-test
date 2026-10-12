--==============================================================
-- Table: warenverfuegbarkeit_wup_art_stunde_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: warenverfuegbarkeit_wup_art_stunde_2
   generated from Powerdesigner on Dienstag, 27. August 2024 15:57:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WARENVERFUEGBARKEIT_WUP_ART_STUNDE_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_2 verkauft wird.',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID des verkauften Artikel.',
   dat_auswertung                      DATE             NOT NULL COMMENT 'Datum der Auswertung im Format JJJJ-MM_2-TT.',
   zeit_stunde                         NUMBER(38,0)     NOT NULL COMMENT 'Volle Stunde (00 bis 23) der Auswertung.',
   bewart_id                           NUMBER(38,0)     COMMENT 'Bewegungsart des verkauften Artikels. 1002 = SA = Sonderaktion (Werbeartikel), 1001 = AF = Aktionsfrei (kein Werbeartikel)',
   anz_bon_artikel                     NUMBER(38,0)     COMMENT 'Anzahl der Bons, in denen der Artikel_2 in diesem Zeitraum verkauft wurde.',
   menge_verkauft                      NUMBER(38,3)     COMMENT 'Gesamtverkaufte Menge des Artikels in diesem Zeitraum. Es kann sowohl in Stück als auch in Kilogramm angegeben sein (je nach Artikel_2).',
   anz_bon_gesamt                      NUMBER(38,0)     COMMENT 'Gesamtzahl der erstellten Bons in der Filiale in diesem Zeitraum. Unabhängig von der Anzahl der verkauften Artikel. Die Anzahl kann aufgrund von Abschriften_2 und Retouren von den Daten in DBP_ODS.ODS_BON_VERKAUF_2 abweichen.',
   ausverkauft_fg                      NUMBER(38,0)     COMMENT 'Kennzeichen, das angibt, ob der Artikel_2 in diesem Zeitraum vollständig ausverkauft war.',
   eckartikel_fg                       NUMBER(38,0)     COMMENT 'Kennzeichen, das angibt ob der Artikel_2 in diesem Zeitraum ein Eckartikel ist. Unter einem Eckartikel versteht man einen Artikel_2, auf den die Kunden besonders achten und der dementsprechend immer verfügbar sein sollte.',
   topseller_fg                        NUMBER(38,0)     COMMENT 'Kennzeichen, das angibt, ob der Artikel_2 einer der 25 meistverkauften Artikel_2 der letzten 3 Jahre ist.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WARENVERFUEGBARKEIT_WUP_ART_STUNDE PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_auswertung, zeit_stunde) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält detaillierte Informationen über die stündliche Verfügbarkeit der Artikel. Sie bezieht sich nur auf O&G und Backartikel, die entweder Eckartikel oder Topseller sind. Sie dient der Analyse von Abverkäufen und Out-of-Stock-Situationen.';
