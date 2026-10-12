CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BUCHUNGSKREIS
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
       FROM dbp_view.v_l_buchungskreis
       WHERE mandant_id = 1
 ;