CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MANDANT_2
(
mandant_id
,mandant_bez
,mandant_kbez
,mandant_sort_id
)
AS
--02.01.2023 twie: NSR3425817 mandant_sort_id hinzugefügt

   SELECT
     mandant_id
   , mandant_bez
   , mandant_kbez
   ,mandant_sort_id
   FROM dbp_view.v_mandant_2;