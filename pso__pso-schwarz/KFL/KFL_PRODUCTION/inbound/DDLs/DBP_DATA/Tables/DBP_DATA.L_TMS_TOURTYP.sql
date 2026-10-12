--==============================================================
-- Table: l_tms_tourtyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_tourtyp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_TOURTYP (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_tourtyp_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Tourtyps. Aus plini.entry',
   tms_tourtyp_lfd_nr                  NUMBER(38,0)     NOT NULL COMMENT 'SKey für die Tabelle l_tms_tourtyp im Quellsystem. Aus plini.ini_id',
   tms_tourtyp_bez                     VARCHAR(300)     NOT NULL COMMENT 'Bezeichnung zum Tourtyp. z. B. 105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_TOURTYP PRIMARY KEY (mandant_id, system_id, tms_tourtyp_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Touren für verschiedene Tourtypen (z.B. "01 - Zutour - keine Abrechnung", "02 - Abholung Lieferant", usw). Es dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. Aus der Quelle plini (WANKO)';
