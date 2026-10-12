CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MANDANT_2
-- 25.03.2014 twie: Währung ausgeben, die der User sich selbst eingestellt hat
(
mandant_id
,mandant_bez
,mandant_kbez
,wrg_id
)
AS
   SELECT
   v01.mandant_id, v01.mandant_bez, v01.mandant_kbez, CASE
   --Land_2
   WHEN v02.wrg_typ_id = 1 THEN v01.default_wrg
   ELSE 'EUR'
   END AS wrg_id

   FROM dbp_view.v_mandant_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02;