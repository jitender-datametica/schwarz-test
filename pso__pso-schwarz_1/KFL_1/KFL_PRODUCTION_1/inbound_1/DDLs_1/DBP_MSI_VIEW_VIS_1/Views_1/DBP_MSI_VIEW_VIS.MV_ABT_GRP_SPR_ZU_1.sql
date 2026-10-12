CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_GRP_SPR_ZU_1 as
   -- SPRACHE : Abteilungsgruppe
   -- NICHT userabhaengige Bezeichnung
   -- 2010KW07 : 3stellige WG

   SELECT
   v01.mandant_id, v01.abt_grp_id, v01.abt_grp_bez, v01.spr_id

   FROM dbp_view.v_abt_grp_spr_zu_1 v01

   WHERE v01.spr_id = 22

/*
--INNER JOIN dbe_msi_v_view.v_user_spr_zu_1 v02
--ON  USER = v02.user_id
--AND v01.spr_id = v02.spr_id
*/
;