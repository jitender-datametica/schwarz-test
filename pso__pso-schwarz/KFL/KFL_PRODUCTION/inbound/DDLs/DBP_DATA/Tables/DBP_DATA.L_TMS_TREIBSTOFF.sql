--==============================================================
-- Table: l_tms_treibstoff
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_treibstoff
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_TREIBSTOFF (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_treibstoff_id                   NUMBER(38,0)     NOT NULL COMMENT 'ID des Treibstoffs (Nummer des Treibstoffs). Aus pltrst.trst_nr',
   tms_treibstoff_lfd_nr               NUMBER(38,0)     NOT NULL COMMENT 'SKey für die Tabelle l_tms_treibstoff im Quellsystem. Aus pltrst.trst_id',
   tms_treibstoff_bez                  VARCHAR(50)      NOT NULL COMMENT 'Bezeichnung zum Treibstoff',
   menge_einh_id                       VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Einheit des Treibstoffs  ("L" und "KWH" gibt es auch in SAP)',
   menge_co2_pro_einheit               NUMBER(9,2)      COMMENT 'CO2-Emission pro verbrauchter Einheit in kg',
   menge_co2_aeq_pro_einheit           NUMBER(9,2)      COMMENT 'CO2-Äquivalenzwert pro verbrauchter Einheit in Kg',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_TREIBSTOFF PRIMARY KEY (mandant_id, system_id, tms_treibstoff_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Speicherung von Informationen über verschiedene Kraftstoffarten, z. B. Diesel, Strom. Aus der Quelle pltrst (WANKO)';
