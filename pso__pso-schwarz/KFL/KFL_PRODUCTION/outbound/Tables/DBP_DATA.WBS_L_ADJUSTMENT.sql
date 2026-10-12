--==============================================================
-- Table: wbs_l_adjustment
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_adjustment
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_adjustment (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
adjustment_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.'),
adjustment_bez STRING(200) NOT NULL OPTIONS(description='Beschreibung der adjustment_id, z. B. Standard adjustment'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, adjustment_id) NOT ENFORCED
)
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.             0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R             1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.             2 = Platzhalter (Stand 28.03.2025)             3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. ');