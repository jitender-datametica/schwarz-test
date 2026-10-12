CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_PERS_TEILBEREICH_ZU_PER
(
mandant_id
,pers_bereich_id
,pers_teilbereich_id
,mitarbeiter_id
,kjmo
,buchungskreis_id
,persteilbereich_bez

)
AS
   SELECT
   v01.mandant_id, v01.pers_bereich_id, v01.pers_teilbereich_id, v01.mitarbeiter_id, v01.kjmo, v01.buchungskreis_id, v02.persteilbereich_bez



   FROM dbp_view.v_ma_pers_teilbereich_zu_per v01
   JOIN dbp_view.v_pers_teilbereich_spr_zu          v02
   ON   v01.mandant_id               = v02.mandant_id
   AND v01.pers_bereich_id      = v02.pers_bereich_id
   AND v01.pers_teilbereich_id = v02.pers_teilbereich_id
   AND v01.buchungskreis_id    = v02.buchungskreis_id
   AND v02.spr_id = 22;