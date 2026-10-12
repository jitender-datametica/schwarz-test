--==============================================================

-- Table: aktion_art_wup_zu_wme_ame
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_wup_zu_wme_ame
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_ART_WUP_ZU_WME_AME (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Aktionsnummer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_ART_WUP_ZU_WME_AME PRIMARY KEY (mandant_id, aktion_id, art_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'VIS - Artikel-Filiale Zuordnung zu einer Aktion  nur für WME (Werbemenegeneinholung) und AME (Allg. Menegeneinholung) - die Aktionen liegen in der Zukunft und überschneiden sich nicht mit den Aktionen in Tabelle Aktion- SAP RET - WALE';

