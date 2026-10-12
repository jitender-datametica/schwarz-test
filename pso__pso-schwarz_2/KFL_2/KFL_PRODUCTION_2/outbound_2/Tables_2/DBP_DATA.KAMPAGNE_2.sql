--==============================================================
-- Table: kampagne_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne_2, die der GUID im Quellsystem entspricht.'),
kampagne_name STRING(200) NOT NULL OPTIONS(description='Bezeichnender Name der Kampagnendefinition.'),
dat_kampagne_von DATE OPTIONS(description='Datum, an dem die Kampagne_2 startet wird.'),
dat_kampagne_bis DATE OPTIONS(description='Datum, an dem die Kampagne_2 endet.'),
kampagne_rhythmus_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_2, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'),
kampagne_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Version der Kampagne. Bei jedem Auslösen einer Kampagne_2 wird eine_2 neue Version erstellt. Diese Zahl entspricht der genutzen Version.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.');