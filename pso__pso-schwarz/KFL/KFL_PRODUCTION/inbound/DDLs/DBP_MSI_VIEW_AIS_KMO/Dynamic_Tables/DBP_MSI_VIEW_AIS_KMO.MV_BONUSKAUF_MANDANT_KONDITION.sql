CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_BONUSKAUF_MANDANT_KONDITION
(
 mandant_id
,bonuskauf_id
,konditionsart_id
,geschaeftsvorfall_id
,dat_von
,dat_bis
,zeit_von
,zeit_bis
,dat
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT * FROM
  (
  SELECT
  v01.mandant_id,
   v01.bonuskauf_id,
   v01.konditionsart_id,
   v01.geschaeftsvorfall_id,
   v01.dat_von,
   v01.dat_bis,
   v01.zeit_von,
   v01.zeit_bis,
   v02.dat

   FROM dbp_view.v_l_bonuskauf v01
   JOIN dbp_view.v_tag v02
   ON      v01.dat_von <= v02.dat
   AND   v01.dat_bis   >= v02.dat

   WHERE v01.mandant_id <> 1
   ) ALLES
   WHERE   ALLES.dat + 730 > CURRENT_DATE
   AND          ALLES.dat            < CURRENT_DATE  + 730;