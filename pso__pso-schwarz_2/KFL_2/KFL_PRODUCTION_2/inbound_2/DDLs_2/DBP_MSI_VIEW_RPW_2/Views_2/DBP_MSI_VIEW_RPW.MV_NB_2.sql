CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_NB_2
 --   12.07.2010 A. Lipkin  nb_id =99 aufgenommen
 (
 nb_id
 ,nb_bez
 ,system_id
 )
 AS
    SELECT
    nb_id,
    nb_bez,
    7
    FROM dbp_view.v_nb_2
    where nb_id in (-111,0,2, 99);