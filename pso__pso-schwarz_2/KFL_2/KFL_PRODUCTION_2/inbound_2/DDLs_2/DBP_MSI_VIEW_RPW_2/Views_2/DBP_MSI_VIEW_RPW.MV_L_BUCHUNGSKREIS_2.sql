CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BUCHUNGSKREIS_2
    (
      mandant_id
      ,buchungskreis_id
      ,system_id
    )
    AS
       SELECT
          mandant_id,
       buchungskreis_id,
       7 AS system_id
       FROM dbp_view.v_l_buchungskreis_2
       WHERE mandant_id = 1
 ;