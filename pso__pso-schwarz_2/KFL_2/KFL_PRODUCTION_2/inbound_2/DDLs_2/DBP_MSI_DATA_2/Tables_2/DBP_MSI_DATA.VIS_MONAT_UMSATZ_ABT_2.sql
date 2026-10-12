--==============================================================
-- Table: vis_monat_umsatz_abt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_umsatz_abt_2
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:02:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_MONAT_UMSATZ_ABT_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   abt_id                              NUMBER(38,0)     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   gj                                  NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahr',
   akt_gj                              NUMBER(38,0)     NOT NULL COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres',
   akt_mo                              NUMBER(38,0)     NOT NULL COMMENT 'Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 0, der vorige Monat_2 -1 und der nächste Monat_2 den Wert 1',
   mo_kj                               NUMBER(38,0)     NOT NULL COMMENT 'Laufender Monat_2 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12',
   ums_netto                           NUMBER(38,2)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_kvj                       NUMBER(38,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_kvvj                      NUMBER(38,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   ums_netto_plan                      NUMBER(38,2)     NOT NULL COMMENT 'Umsatz netto Planwert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_MONAT_UMSATZ_ABT PRIMARY KEY (mandant_id, wup_id, nb_id, wrg_id, kjmo, abt_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Monatsebene - MULTISET';
