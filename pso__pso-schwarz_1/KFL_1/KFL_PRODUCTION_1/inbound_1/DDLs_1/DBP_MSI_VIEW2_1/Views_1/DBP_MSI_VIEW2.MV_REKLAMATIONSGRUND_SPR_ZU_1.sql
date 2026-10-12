CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REKLAMATIONSGRUND_SPR_ZU_1
(
reklamationsgrund_id
,reklamationsgrund_bez
,mandant_id
,spr_id

)
AS
   SELECT
  reklamationsgrund_id, reklamationsgrund_bez, mandant_id, spr_id
   FROM dbp_view.v_reklamationsgrund_spr_zu_1
   WHERE spr_id = 22 AND mandant_id=1;