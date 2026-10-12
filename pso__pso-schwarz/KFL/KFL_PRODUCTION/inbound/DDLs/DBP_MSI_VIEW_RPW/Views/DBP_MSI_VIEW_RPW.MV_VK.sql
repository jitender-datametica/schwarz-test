CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VK
    (
      vk_id
      ,vk_bez
      ,mandant_id
      ,system_id
    )
    AS
       SELECT
          vk_id,
       vk_bez,
       mandant_id,
       7
       FROM dbp_view.v_vk
       WHERE mandant_id = 1
 ;