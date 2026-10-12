CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VK_2
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
       FROM dbp_view.v_vk_2
       WHERE mandant_id = 1
 ;