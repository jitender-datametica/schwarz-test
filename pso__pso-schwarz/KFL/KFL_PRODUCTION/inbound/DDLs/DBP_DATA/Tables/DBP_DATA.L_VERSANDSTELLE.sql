--==============================================================
-- Table: l_versandstelle
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_versandstelle
   generated from Powerdesigner on Dienstag, 30. November 2021 11:31:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_VERSANDSTELLE (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   versandstelle_id                    VARCHAR(4)      NOT NULL COMMENT 'Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.',
   artikelsortiment_id                 VARCHAR(1)      COMMENT 'Artikelsortiment ID',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'TP408_LVS - In dieser Tabelle sind die Schlüssel der Versandstellen für die Lieferungen enthalten. - MULTISET';