CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ARTKZ_DISCOUNT_2
-- 09.12.2013 twie: neue Lookup von AIS_DE uebernommen, fuer CZ ein Dummyeintrag
(
discount_id,
discount_bez,
mandant_id
)
AS
   SELECT
   v01.discount_id,
   v01.discount_bez,
   v01.mandant_id

   FROM dbp_view.v_artkz_discount_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id = 1


   UNION ALL


   SELECT
   0 AS discount_id,
   '' AS discount_bez,
   mandant_id

   FROM dbp_view.v_mandant_2

   WHERE mandant_id = 2;