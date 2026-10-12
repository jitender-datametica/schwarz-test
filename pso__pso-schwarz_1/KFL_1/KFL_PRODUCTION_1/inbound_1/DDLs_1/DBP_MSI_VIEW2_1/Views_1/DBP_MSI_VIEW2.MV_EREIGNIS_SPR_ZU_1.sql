CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EREIGNIS_SPR_ZU_1
(
ereignis_id
,ereignis_bez_lang
,ereignistyp_id
,spr_id
,ereignis_bez_mittel
,ereignis_bez_kurz
)
AS
   SELECT
  ereignis_id, ereignis_bez_lang, ereignistyp_id, spr_id, ereignis_bez_mittel, ereignis_bez_kurz

   FROM dbp_view.v_ereignis_spr_zu_1
   WHERE spr_id=22
   AND mandant_id = 1;