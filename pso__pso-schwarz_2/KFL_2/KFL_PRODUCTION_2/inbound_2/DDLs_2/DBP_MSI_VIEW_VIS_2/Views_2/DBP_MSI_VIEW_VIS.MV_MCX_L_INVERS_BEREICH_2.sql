CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_INVERS_BEREICH_2 as
   -- LU : KMR/MCX Bereich (Inverse Hierarchie)
   -- 2019.0809 ssch0611 VTC-KMR Redesign (Init)
   -- 2019.0917 ssch0611 : SORT + FILTER added (join bereich_inv_bereich)

   SELECT
   ibe.invers_ber_id, ibe.invers_kat_id, bib.umfrage_id, bib.ber_sort      AS invers_ber_sort, bib.filter_fg     AS invers_ber_filter_fg

   FROM dbp_view.v_mcx_l_invers_bereich_2 ibe
   LEFT JOIN dbp_view.v_mcx_bereich_invers_bereich_zu_2 bib
   ON bib.invers_ber_id = ibe.invers_ber_id;