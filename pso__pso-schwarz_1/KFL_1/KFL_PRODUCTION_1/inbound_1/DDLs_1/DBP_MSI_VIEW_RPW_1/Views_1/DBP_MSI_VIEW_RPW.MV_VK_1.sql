CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VK_1
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
       FROM dbp_view.v_vk_1
       WHERE mandant_id = 1
 ;