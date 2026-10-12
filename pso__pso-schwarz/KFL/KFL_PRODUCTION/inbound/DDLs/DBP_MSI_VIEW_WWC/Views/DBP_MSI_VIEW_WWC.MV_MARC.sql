CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MARC
(
art_id
,dat_bis
,dat_von
,mandant_id
,nb_id
,wup_id
,DISMM
,BWSCL
,EISLO
)
AS
   SELECT
  v01.art_id, v01.dat_bis, v01.dat_von, v01.mandant_id, v01.nb_id, v01.wup_id, v01.dispomerkmal AS DISMM, v01.bezugsweg_id AS BWSCL, v01.min_sicherh_bestand AS EISLO
   FROM dbp_view.v_art_wup_status_per v01
   WHERE v01.dat_bis = DATE '9999-12-31'
   AND v01.mandant_id <> 1
   -- 20100330 Filterung der IWT Betriebe
   AND v01.nb_id <> 99;