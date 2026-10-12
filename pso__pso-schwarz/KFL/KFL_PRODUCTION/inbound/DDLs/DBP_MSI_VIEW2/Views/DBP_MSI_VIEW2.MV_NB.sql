CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_NB (nb_id ,nb_bez)
AS
   SELECT nb_id, nb_bez from dbp_view.v_nb;