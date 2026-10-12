CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_ARTIKELTYP_1
(
mandant_id
,ATTYP
)
AS

   SELECT
   v01.mandant_id, v01.artikeltyp_id AS ATTYP

   FROM dbp_view.v_l_artikeltyp_1 v01
;