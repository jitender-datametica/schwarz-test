CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WUP_2
AS
   SELECT
   wup_id,
   nb_id,
   mandant_id,
   dat_von,
   dat_bis,
   dat_eroeffnung,
   breitengrad,
   laengengrad
   FROM dbp_view.v_wup_2  v01;