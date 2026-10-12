CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_LIEF_PAL_TYP_SPR_ZU_1
-- #613296 Splitt Palettentyp 6 in 61 und 64 - sschuecke 10.06.2015
AS
      SELECT
   v01.lief_pal_typ_bez, v01.lief_pal_typ_id, v01.mandant_id, v01.spr_id
   FROM

   (
   SELECT
   lief_pal_typ_bez, try_to_numeric(lief_pal_typ_id) as lief_pal_typ_id, mandant_id, spr_id

   FROM dbp_view.v_lief_pal_typ_spr_zu_1
   /*JOIN dbp_msi.akt_msi_user_spr_zu_1 v03
   ON v01.spr_id = v03.spr_id*/

   UNION

   SELECT
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez, 61 AS lief_pal_typ_id, mandant_id, spr_id

   FROM dbp_view.v_lief_pal_typ_spr_zu_1
   /*JOIN dbp_msi.akt_msi_user_spr_zu_1 v04
   ON v02.spr_id = v04.spr_id*/

   UNION

   SELECT
   'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez, 64 AS lief_pal_typ_id, mandant_id, spr_id

   FROM dbp_view.v_lief_pal_typ_spr_zu_1
   ) v01

;