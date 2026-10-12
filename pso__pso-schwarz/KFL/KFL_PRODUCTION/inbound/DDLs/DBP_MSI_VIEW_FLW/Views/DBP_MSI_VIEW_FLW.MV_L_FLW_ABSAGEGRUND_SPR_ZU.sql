CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_ABSAGEGRUND_SPR_ZU
-- 18.09.2015 twie: Dummywert -1 dazu

(
mandant_id
, absagegrund_id
,absagegrund_bez
)
AS
   SELECT

   v01.mandant_id, v01.absagegrund_id, v01.absagegrund_bez

   FROM dbp_view.v_flw_absagegrund_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   UNION

   SELECT

   v02.mandant_id, '-1' AS absagegrund_id, '' AS absagegrund_bez

   FROM dbp_view.v_mandant v02
   WHERE v02.mandant_id IN (1,2);