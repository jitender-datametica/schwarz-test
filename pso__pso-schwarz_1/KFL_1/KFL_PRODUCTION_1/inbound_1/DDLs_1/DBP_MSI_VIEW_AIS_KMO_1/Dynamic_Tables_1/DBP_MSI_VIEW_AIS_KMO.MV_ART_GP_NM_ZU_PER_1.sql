CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_GP_NM_ZU_PER_1
(
mandant_id
,art_id
,wup_id
,nb_id
,dat_von
,gp_id
,einkaufsorganisation_id
,dat_bis
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.mandant_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat_von,
   v01.gp_id,
   v01.einkaufsorganisation_id,
   v01.dat_bis
   FROM dbp_view.v_art_gp_nm_zu_per_1 v01
   WHERE v01.mandant_id <> 1;