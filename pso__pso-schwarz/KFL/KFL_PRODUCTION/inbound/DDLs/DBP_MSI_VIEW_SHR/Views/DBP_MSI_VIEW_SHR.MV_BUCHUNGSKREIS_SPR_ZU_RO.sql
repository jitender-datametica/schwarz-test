CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_BUCHUNGSKREIS_SPR_ZU_RO
(
mandant_id
, buchungskreis_id
, system_id
, buchungskreis_bez
)
AS
   SELECT
   v01.mandant_id, v01.buchungskreis_id, v01.system_id, v01.buchungskreis_bez

   FROM dbp_view.v_buchungskreis_spr_zu v01
   WHERE v01.system_id IN (85,87,95)
   AND v01.spr_id = 95
;