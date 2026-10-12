CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_INVERS_KATEGORIE_2 as
   -- LU : KMR/MCX Kategorie (Inverse Hierarchie)
   -- 2019.0809 ssch0611 VTC-KMR Redesign (Init)
   -- 2019.0817 ssch0611 check

   SELECT
   invers_kat_id, invers_kat_sort, umfrage_id
   FROM dbp_view.v_mcx_l_invers_kategorie_2;