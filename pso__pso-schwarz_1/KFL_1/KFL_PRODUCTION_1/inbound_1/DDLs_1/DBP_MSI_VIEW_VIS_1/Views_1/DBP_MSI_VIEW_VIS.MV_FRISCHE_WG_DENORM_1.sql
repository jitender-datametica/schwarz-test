CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FRISCHE_WG_DENORM_1 as
   -- LOOKUP/SPRACHE Fruehinfo Frischeinventur Warengruppe
   -- Eigene WG (arthiertyp_1 2)
   -- 2009KW37 Initial Frischeinventur DE
   -- 2010KW28 Review

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id         AS frische_wg_id, v02.wg_bez        AS frische_wg_bez, v02.spr_id

   FROM dbp_view.v_wg_per_1  v01

   JOIN dbp_view.v_wg_spr_zu_1  v02
   ON  v02.mandant_id = v01.mandant_id
   AND v02.arthiertyp_id = v01.arthiertyp_id
   AND v02.wg_id = v01.wg_id

   WHERE v01.dat_bis = '9999-12-31'
   AND v01.arthiertyp_id = 2
   AND v01.mandant_id = 1
   AND v02.spr_id = 22;