CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_LIEFERANT_INT
         -- SH 13.06.2013 initial
         -- SROM, 03.12.2014 lief_name_1 umbenannt, lief_name_2 in Datenmodell entfernt
         --
         (
         in_lief_id_int
         ,lief_name
         )
         AS
            SELECT
            v01.in_lief_id_int,
            v01.lief_name
           FROM dbp_view.v_in_lieferant_int v01
;