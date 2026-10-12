CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_GESCHLECHT_SPR_ZU_RO_1
(
mandant_id
,geschlecht_id
,spr_id
,geschlecht_bez
,anrede_bez

)
AS
   SELECT
   v01.mandant_id, v01.geschlecht_id, v01.spr_id, v01.geschlecht_bez, v01.anrede_bez

   FROM dbp_view.v_ma_geschlecht_spr_zu_1 v01

   WHERE spr_id = 95;