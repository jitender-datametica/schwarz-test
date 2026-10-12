CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IT_PROJEKT_STATUS_SPR_ZU_HR_1 AS
-- 15.04.2013 AL Init

   SELECT
   it_projekt_status_id,
   it_projekt_status_bez
  FROM dbp_view.v_it_projekt_status_spr_zu_1
  WHERE spr_id=65
;