--==============================================================
-- Table: wbs_l_adjustment_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_adjustment_2
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_L_ADJUSTMENT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   adjustment_id                       INTEGER     NOT NULL COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.',
   adjustment_bez                      VARCHAR(200)     NOT NULL COMMENT 'Beschreibung der adjustment_id, z. B. Standard adjustment',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_L_ADJUSTMENT PRIMARY KEY (mandant_id, adjustment_id) NOT ENFORCED
)  COMMENT = 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
             0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
             1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
             2 = Platzhalter (Stand 28.03.2025)
             3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig. ';
