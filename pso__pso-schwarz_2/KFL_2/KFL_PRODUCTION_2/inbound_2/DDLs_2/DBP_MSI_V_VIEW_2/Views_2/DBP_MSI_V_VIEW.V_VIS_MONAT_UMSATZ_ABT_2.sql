CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_VIS_MONAT_UMSATZ_ABT_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,wup_id                                   COMMENT 'Nummer des Warenumschlagsplatzes'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,kjmo                                     COMMENT 'Kalenderjahremonat, Format JJJJMM'
  ,abt_id                                   COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'
  ,arthiertyp_id                            COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'
  ,gj                                       COMMENT 'Geschäftsjahr'
  ,akt_gj                                   COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres'
  ,akt_mo                                   COMMENT 'Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 0, der vorige Monat_2 -1 und der nächste Monat_2 den Wert 1'
  ,mo_kj                                    COMMENT 'Laufender Monat_2 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'
  ,ums_netto                                COMMENT 'Umsatz netto'
  ,ums_netto_kvj                            COMMENT 'Umsatz netto Kalendertag im Vorjahr'
  ,ums_netto_kvvj                           COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr'
  ,ums_netto_plan                           COMMENT 'Umsatz netto Planwert'
)
COMMENT = 'VIS - Aggregat auf Monatsebene - MULTISET'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        wrg_id,
        kjmo,
        abt_id,
        arthiertyp_id,
        gj,
        akt_gj,
        akt_mo,
        mo_kj,
        ums_netto,
        ums_netto_kvj,
        ums_netto_kvvj,
        ums_netto_plan

FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_ABT_2 ;