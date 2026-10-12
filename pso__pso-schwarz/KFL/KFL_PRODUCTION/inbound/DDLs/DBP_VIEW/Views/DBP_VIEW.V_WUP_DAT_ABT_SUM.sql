CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_DAT_ABT_SUM (
   mandant_id                               COMMENT 'PK Mandant im DWH'
  ,wup_id                                   COMMENT 'PK Warenumschlagsplatz'
  ,nb_id                                    COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat                                      COMMENT 'PK - Datum im Format JJJJ-MM-TT'
  ,abt_id                                   COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'
  ,arthiertyp_id                            COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'
  ,bonanzahl                                COMMENT 'Anzahl der Kassenbons'
  ,bonanzahl_pre_pack                       COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln'
  ,bonanzahl_sug                            COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'
)
COMMENT = 'VIS - Tages-Aggregat pro Markt und Abteilung'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        abt_id,
        arthiertyp_id,
        bonanzahl,
        bonanzahl_pre_pack,
        bonanzahl_sug

FROM DBP_DATA.WUP_DAT_ABT_SUM ;