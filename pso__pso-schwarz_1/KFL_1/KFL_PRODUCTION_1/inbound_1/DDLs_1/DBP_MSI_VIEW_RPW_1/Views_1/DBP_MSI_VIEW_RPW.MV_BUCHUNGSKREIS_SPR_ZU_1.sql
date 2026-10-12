CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCHUNGSKREIS_SPR_ZU_1
 (
   mandant_id
   ,buchungskreis_id
   ,spr_id
   ,buchungskreis_bez
   ,system_id
 )
 AS
    SELECT
      mandant_id,
    buchungskreis_id,
    spr_id,
    buchungskreis_bez,
    7
    FROM dbp_view.v_buchungskreis_spr_zu_1
    WHERE mandant_id = 1
      AND spr_id = 22
 ;