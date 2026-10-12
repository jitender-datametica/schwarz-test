CREATE OR REPLACE VIEW DBP_VIEW.V_WARENVERFUEGBARKEIT_WUP_ART_STUNDE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,wup_id                                   COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'
  ,art_id                                   COMMENT 'ID des verkauften Artikel.'
  ,dat_auswertung                           COMMENT 'Datum der Auswertung im Format JJJJ-MM_1-TT.'
  ,zeit_stunde                              COMMENT 'Volle Stunde (00 bis 23) der Auswertung.'
  ,bewart_id                                COMMENT 'Bewegungsart des verkauften Artikels. 1002 = SA = Sonderaktion (Werbeartikel), 1001 = AF = Aktionsfrei (kein Werbeartikel)'
  ,anz_bon_artikel                          COMMENT 'Anzahl der Bons, in denen der Artikel_1 in diesem Zeitraum verkauft wurde.'
  ,menge_verkauft                           COMMENT 'Gesamtverkaufte Menge des Artikels in diesem Zeitraum. Es kann sowohl in Stück als auch in Kilogramm angegeben sein (je nach Artikel_1).'
  ,anz_bon_gesamt                           COMMENT 'Gesamtzahl der erstellten Bons in der Filiale in diesem Zeitraum. Unabhängig von der Anzahl der verkauften Artikel. Die Anzahl kann aufgrund von Abschriften_1 und Retouren von den Daten in DBP_ODS.ODS_BON_VERKAUF_1 abweichen.'
  ,ausverkauft_fg                           COMMENT 'Kennzeichen, das angibt, ob der Artikel_1 in diesem Zeitraum vollständig ausverkauft war.'
  ,eckartikel_fg                            COMMENT 'Kennzeichen, das angibt ob der Artikel_1 in diesem Zeitraum ein Eckartikel ist. Unter einem Eckartikel versteht man einen Artikel_1, auf den die Kunden besonders achten und der dementsprechend immer verfügbar sein sollte.'
  ,topseller_fg                             COMMENT 'Kennzeichen, das angibt, ob der Artikel_1 einer der 25 meistverkauften Artikel_1 der letzten 3 Jahre ist.'
)
COMMENT = 'Die Tabelle enthält detaillierte Informationen über die stündliche Verfügbarkeit der Artikel. Sie bezieht sich nur auf O&G und Backartikel, die entweder Eckartikel oder Topseller sind. Sie dient der Analyse von Abverkäufen und Out-of-Stock-Situationen.'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat_auswertung,
        zeit_stunde,
        bewart_id,
        anz_bon_artikel,
        menge_verkauft,
        anz_bon_gesamt,
        ausverkauft_fg,
        eckartikel_fg,
        topseller_fg

FROM DBP_DATA.WARENVERFUEGBARKEIT_WUP_ART_STUNDE_1 ;