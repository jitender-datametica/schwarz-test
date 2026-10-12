CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_ALTERSSTRUKTUR_SPR_ZU as
   SELECT
   v01.altersstruktur_id, v01.altersstruktur_bez, v01.spr_id
   FROM dbp_view.v_altersstruktur_spr_zu  v01

   WHERE v01.spr_id = 22 --deutsch
;