CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_SOLL_HABEN_1
(
soll_haben_kz
, mandant_id
)
AS

   SELECT
   'S' AS soll_haben_kz, mandant_id
   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1

   UNION ALL

   SELECT
   'H' AS soll_haben_kz, mandant_id
   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1
;