--==============================================================
-- Table: kampagne_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagne_1, die der GUID im Quellsystem entspricht.',
   kampagne_name                       VARCHAR(200)     NOT NULL COMMENT 'Bezeichnender Name der Kampagnendefinition.',
   dat_kampagne_von                    DATE             COMMENT 'Datum, an dem die Kampagne_1 startet wird.',
   dat_kampagne_bis                    DATE             COMMENT 'Datum, an dem die Kampagne_1 endet.',
   kampagne_rhythmus_typ_id            NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_1, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
   kampagne_version_nr                 NUMBER(38,0)     NOT NULL COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne_1 wird eine_1 neue Version erstellt. Diese Zahl entspricht der genutzen Version.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE PRIMARY KEY (mandant_id, kampagne_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.';
