CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_BEREICH_2 as
   -- 20180502 twie: SPEC0037245 Neuanlage Lookup Bereich in Maritz, Bereich wird in DWH generiert, existiert nicht im Quellsystem Maritz
   -- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
   -- 20190829 twie: SPEC0059325  Filterung auf Umfrage 20 entfernt
   -- 2019.0917 ssch0611 : SORT + FILTER added (join bereich_inv_bereich)

   SELECT
   ber.ber_id, ber.umfrage_id, Coalesce (bib.filter_fg, 1) AS ber_filter_fg, Coalesce (bib.ber_sort, -1) AS ber_sort
   FROM dbp_view.v_mcx_l_bereich_2 ber
   LEFT JOIN (
   SELECT DISTINCT ber_id, umfrage_id, filter_fg, ber_sort
   FROM dbp_view.v_mcx_bereich_invers_bereich_zu_2
   ) bib
   ON bib.ber_id = ber.ber_id;