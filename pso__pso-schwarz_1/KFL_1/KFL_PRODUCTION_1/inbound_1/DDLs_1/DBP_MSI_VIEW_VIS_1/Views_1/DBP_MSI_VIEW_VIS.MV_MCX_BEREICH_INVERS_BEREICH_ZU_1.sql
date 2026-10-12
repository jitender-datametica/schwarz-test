CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_BEREICH_INVERS_BEREICH_ZU_1 as
   -- LU : KMR/MCX Filter for Bereich / Inverse Bereich
   -- 2019.0809 ssch0611 VTC-KMR Redesign (Init)
   -- 2019.0911 ssch0611 SORT added > used via join in lookups

   SELECT
   ber_id, invers_ber_id, ber_sort, umfrage_id, filter_fg
   FROM dbp_view.v_mcx_bereich_invers_bereich_zu_1;