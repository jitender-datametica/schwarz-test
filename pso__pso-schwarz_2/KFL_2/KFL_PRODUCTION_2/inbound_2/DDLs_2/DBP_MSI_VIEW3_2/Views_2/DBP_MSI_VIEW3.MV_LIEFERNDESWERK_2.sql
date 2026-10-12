CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEFERNDESWERK_2
(
lieferndeswerk
,lieferndeswerk_nb_id
,mandant_id
,dat_von
,wup_typ_id
,wup_standort
,dat_bis
,verkaufsorganisation_id
)
AS
   SELECT
   wup_id, nb_id, mandant_id, dat_von, wup_typ_id, wup_standort, dat_bis, verkaufsorganisation_id
   FROM dbp_view.v_wup_2
   WHERE nb_id=-111;