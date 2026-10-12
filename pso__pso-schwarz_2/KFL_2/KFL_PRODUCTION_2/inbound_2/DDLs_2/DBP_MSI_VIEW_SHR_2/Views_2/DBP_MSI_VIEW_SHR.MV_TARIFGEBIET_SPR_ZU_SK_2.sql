CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_TARIFGEBIET_SPR_ZU_SK_2
(
mandant_id
,tarifgebiet_id
,spr_id
,tarifgebiet_bez


)
AS
   SELECT
   v01.mandant_id, v01.tarifgebiet_id, v01.spr_id, v01.tarifgebiet_bez


   FROM dbp_view.v_tarifgebiet_spr_zu_2 v01
   WHERE spr_id = 108
;