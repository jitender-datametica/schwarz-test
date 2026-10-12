CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTIKELTYP_SPR_ZU_BG_2
(
mandant_id
,ATTYP
,spr_id
,artikeltyp_bez
)
AS

   SELECT
   v01.mandant_id, v01.artikeltyp_id AS ATTYP, spr_id, artikeltyp_bez
   FROM dbp_view.v_artikeltyp_spr_zu_2 v01
   WHERE v01.spr_id = 18
;