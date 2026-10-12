CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_SAISON
(
mandant_id
,SAISO
)
AS

   SELECT
   v01.mandant_id, v01.saison_id AS SAISO

   FROM dbp_view.v_l_saison v01
;