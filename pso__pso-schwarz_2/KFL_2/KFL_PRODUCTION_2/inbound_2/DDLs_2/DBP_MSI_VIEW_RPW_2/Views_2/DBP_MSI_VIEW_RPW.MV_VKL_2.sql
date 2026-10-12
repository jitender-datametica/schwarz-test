CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VKL_2
    (
       vkl_id
      ,gf_id
      ,vkl_name
      ,mandant_id
      ,system_id
    )
    AS
       SELECT
          vkl_id,
       gf_id,
       vkl_name,
       mandant_id,
       7 AS system_id
       FROM dbp_view.v_vkl_2
       WHERE  mandant_id = 1
 ;