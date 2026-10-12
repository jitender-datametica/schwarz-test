CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
kampagne_id OPTIONS(description='Eindeutige Kennung der Kampagne_2, die der GUID im Quellsystem entspricht.'),
kampagne_name OPTIONS(description='Bezeichnender Name der Kampagnendefinition.'), dat_kampagne_von
OPTIONS(description='Datum, an dem die Kampagne_2 startet wird.'), dat_kampagne_bis
OPTIONS(description='Datum, an dem die Kampagne_2 endet.'), kampagne_rhythmus_typ_id
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_2, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'),
kampagne_version_nr
OPTIONS(description='Version der Kampagne. Bei jedem Auslösen einer Kampagne_2 wird eine_2 neue Version erstellt. Diese Zahl entspricht der genutzen Version.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT INFORMATIONEN ÜBER DIE CRM KAMPAGNEN, MIT DENEN NACHRICHTEN WIE E-MAIL, PUSH-BENACHRICHTIGUNGEN UND SMS ÜBER VERSCHIEDENE KANÄLE HINWEG VERFOLGT UND ANALYSIERT WERDEN KÖNNEN.`)
AS SELECT mandant_id,
 kampagne_id,
 kampagne_name,
 dat_kampagne_von,
 dat_kampagne_bis,
 kampagne_rhythmus_typ_id,
 kampagne_version_nr
FROM kfl_production_dbp_data.kampagne_2;