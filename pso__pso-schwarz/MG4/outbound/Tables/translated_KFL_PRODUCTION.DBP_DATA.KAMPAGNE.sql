CREATE OR REPLACE TABLE kfl_production_dbp_data.kampagne (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.'),
kampagne_name STRING(200) NOT NULL OPTIONS(description='Bezeichnender Name der Kampagnendefinition.'),
dat_kampagne_von DATE OPTIONS(description='Datum, an dem die Kampagne startet wird.'),
dat_kampagne_bis DATE OPTIONS(description='Datum, an dem die Kampagne endet.'),
kampagne_rhythmus_typ_id INTEGER NOT NULL
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'),
kampagne_version_nr INTEGER NOT NULL
OPTIONS(description='Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.');