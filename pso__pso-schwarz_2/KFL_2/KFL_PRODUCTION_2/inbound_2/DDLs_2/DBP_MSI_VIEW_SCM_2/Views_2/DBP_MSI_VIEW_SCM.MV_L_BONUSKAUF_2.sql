CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_l_bonuskauf_2
-- Übernahme von AIS KMO mit ein paar kleinen Änderungen
-- 19.07.2021 sanadze (Mayko): SPEC0106469 erstellt auf Snowflake
(
 mandant_id
,bonuskauf_id
,bonuskauf_bez
,zeit_von
,zeit_bis
,konditionsart_id
,geschaeftsvorfall_id
,dat_von
,dat_bis
,aktion_id
,spr_id

)
AS

SELECT
 v01.mandant_id
,v01.bonuskauf_id
,v03.bonuskauf_bez
--,CAST( v01.zeit_von AS DATE)  AS zeit_von
--,CAST( v01.zeit_bis AS DATE)  AS zeit_bis

,v01.zeit_von
,v01.zeit_bis
,v01.konditionsart_id
,v01.geschaeftsvorfall_id
,v01.dat_von
,v01.dat_bis
,v01.aktion_id
,v03.spr_id

FROM dbp_view.v_l_bonuskauf_2 v01

JOIN dbp_view.v_bonuskauf_spr_zu_2 v03
ON v01.bonuskauf_id = v03.bonuskauf_id
AND v01.mandant_id = v03.mandant_id;